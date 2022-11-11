import 'dart:io';

import 'package:firestore_sqlite/firestore_sqlite.dart';

import '../utils/file.dart';
import 'base.dart';

String imports({bool graphql = false}) {
  final sb = StringBuffer();
  sb.writeln('import * as functions from "firebase-functions";');
  sb.writeln('import * as admin from "firebase-admin";');
  if (graphql) {
    sb.writeln(
        'import {ApolloServer, gql} from "apollo-server-cloud-functions";');
  }
  sb.writeln();
  sb.writeln('admin.initializeApp(functions.config().firebase);');
  sb.writeln('const db = admin.firestore();');
  return sb.toString();
}

const _template = r'''

async function handelCollection(
  request: functions.https.Request,
  response: functions.Response<any>,
  collection: string,
  ) {
  const method = request.method;
  if (method === "GET") {
    const id = request.query.id;
    if (id && typeof id === "string") {
      const doc = await db.collection(collection).doc(id).get();
      const result = doc.data();
      functions.logger.info(`get ${collection} -> ${result !== undefined}`, { structuredData: true });
      response.send(result);
    } else {
      const docs = await db.collection(collection).get();
      const results = docs.docs.map((doc: any) => ({ ...doc.data(), id: doc.id }));
      functions.logger.info(`get ${collection} -> ${results.length}`, { structuredData: true });
      response.send(results);
    }
  } else if (method === "POST") {
    const data = request.body;
    if (data) {
      const doc = await db.collection(collection).add(data);
      const result = { ...data, id: doc.id };
      functions.logger.info(`post ${collection} -> ${result !== undefined}`, { structuredData: true });
      response.send(result);
    } else {
      response.status(400).send("Bad Request");
    }
  } else if (method === "PUT") {
    const id = request.query.id;
    const data = request.body;
    if (id && typeof id === "string" && data) {
      await db.collection(collection).doc(id).set(data);
      const result = { ...data, id };
      functions.logger.info(`put ${collection} -> ${result !== undefined}`, { structuredData: true });
      response.send(result);
    } else {
      response.status(400).send("Bad Request");
    }
  } else if (method === "DELETE") {
    const id = request.query.id;
    if (id && typeof id === "string") {
      await db.collection(collection).doc(id).delete();
      functions.logger.info(`delete ${collection} -> ${id}`, { structuredData: true });
      response.send(id);
    } else {
      response.status(400).send("Bad Request");
    }
  } else {
    response.status(400).send("Bad Request");
  }
}

{{#collections}}
/**
 * {{name}} - {{description}}
 */
export const collection{{#pascal_case}}{{name}}{{/pascal_case}} = functions.https.onRequest((req, res) => {
  return handelCollection(req, res, "{{name}}");
});
{{/collections}}

{{#all_triggers}}
export const collection{{#pascal_case}}{{collection}}{{/pascal_case}}Trigger = functions.firestore
  .document('{{collection}}/{docId}')
  .onDelete(async (snapshot, context) => { 
    const docId = context.params.docId;
    const batch = db.batch();
    {{#triggers}}
    const {{#camel_case}}{{collection}}{{/camel_case}}Items = await db.collection("{{collection}}").where("{{field}}", "==", docId).get();
    for (const item of {{#camel_case}}{{collection}}{{/camel_case}}Items.docs) {
      batch.delete(item.ref);
    }
    {{/triggers}}
    await batch.commit();
   });
{{/all_triggers}}

{{#graphql}}

const typeDefs = gql`
{{#collections}}
  type {{#pascal_case}}{{name}}{{/pascal_case}} {
    {{#fields}}
    {{#camel_case}}{{name}}{{/camel_case}}: {{graphql_type}}
    {{/fields}}
  }
{{/collections}}
  type Query {
    {{#collections}}    
    {{#camel_case}}{{name}}{{/camel_case}}: [{{#pascal_case}}{{name}}{{/pascal_case}}]
    {{/collections}}
  }
`;

const resolvers = {
  Query: {
    {{#collections}}
    {{#camel_case}}{{name}}{{/camel_case}}: async () => {
      const docs = await db.collection("{{name}}").get();
      return docs.docs.map((doc: any) => ({ ...doc.data(), id: doc.id }));
    },
    {{/collections}}
  },
};

const server = new ApolloServer({
  typeDefs,
  resolvers,
  introspection: true,
  // @ts-ignore
  playground: true,
});

export const graphql = functions.https.onRequest((req, res) => {
  {{#cors}}
  const handler = server.createHandler({
    // @ts-ignore
    cors: { origin: true, credentials: true },
  });
  {{/cors}}
  {{^cors}}
  const handler = server.createHandler();
  {{/cors}}
  return handler(req, res, () => { });
});
{{/graphql}}

''';

const startKey = '// GENERATED_FUNCTIONS_START';
const endKey = '// GENERATED_FUNCTIONS_END';

class FunctionsGenerator extends GeneratorBase {
  FunctionsGenerator({
    required this.outFile,
    required this.collections,
    this.graphql = false,
    this.cors = false,
  });
  final List<Collection> collections;
  final File outFile;
  final bool graphql, cors;

  @override
  String get template => _template;

  @override
  Map<String, Object?> get args {
    final triggers = <String, List<Trigger>>{};
    for (final collection in collections) {
      for (final field in collection.fields) {
        field.type.whenOrNull(
          document: (target, triggerDelete) {
            if (triggerDelete == true) {
              triggers[target] ??= [];
              triggers[target]!.add(Trigger(
                collection: collection.name,
                field: field.name,
              ));
            }
          },
        );
      }
    }
    return {
      'collections': [
        for (final collection in collections)
          {
            ...copyJson(collection) as Map<String, Object?>,
            'fields': [
              for (final field in collection.fields)
                {
                  ...copyJson(field) as Map<String, Object?>,
                  'graphql_type': field.graphqlType,
                }
            ],
          }
      ],
      'graphql': graphql,
      'cors': cors,
      'all_triggers': [
        for (final entry in triggers.entries)
          {
            'collection': entry.key,
            'triggers': entry.value,
          }
      ],
    };
  }

  @override
  String render() {
    final result = super.render();
    outFile.check();
    final content = outFile.readAsStringSync();
    final prefix = imports(graphql: graphql);
    if (content.contains(startKey) && content.contains(endKey)) {
      // Replace tags with content
      final output = content.replaceAllMapped(
        RegExp('$startKey.*$endKey', dotAll: true),
        (match) => result,
      );
      outFile.writeAsStringSync(output);
    } else {
      outFile.writeAsStringSync('$prefix$result');
    }
    return result;
  }
}

class Trigger {
  Trigger({
    required this.collection,
    required this.field,
  });
  final String collection;
  final String field;

  Map<String, Object?> toJson() {
    return {
      'collection': collection,
      'field': field,
    };
  }
}

extension on Field {
  String get graphqlType {
    if (name == 'id') return 'ID!';
    final base = type.when(
      string: (_) => 'String',
      int: () => 'Int',
      double: () => 'Float',
      bool: () => 'Boolean',
      date: () => 'String',
      document: (target, triggerDelete) => 'String',
      array: () => 'String',
      map: () => 'String',
      blob: (_) => 'String',
      dynamic: () => 'String',
      num: () => 'Float',
      option: (values) => 'String',
    );
    if (required == true) {
      return base;
    } else {
      return '$base!';
    }
  }
}
