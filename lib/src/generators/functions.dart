import 'dart:io';

import '../classes/collection.dart';
import '../classes/field.dart';
import '../classes/type.dart';
import '../utils/file.dart';
import '../utils/json.dart';
import 'base.dart';

// TODO: Graphql document fields
// TODO: Graphql mutations

String imports({
  bool graphql = false,
  bool bundles = false,
}) {
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
  if (bundles) {
    sb.writeln('const storage = admin.storage();');
  }
  sb.writeln();
  return sb.toString();
}

const _template = r'''{{#rest}}
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
{{/rest}}

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
export const uploadBundle = functions.https.onRequest(async (req, res) => {
  const bundle = db.bundle("collections-bundle");
  const schema = await db.collection("schema").get();
  bundle.add('schema', schema);
  {{#bundles}}
  const {{name}} = await db.collection("{{name}}").get();
  bundle.add('{{name}}', {{name}});
  {{/bundles}}
  const buffer = bundle.build();
  await storage.bucket().file("collections-bundle").save(buffer);
  res.send(buffer);
});
export const downloadBundle = functions.https.onRequest(async (req, res) => {
  const file = storage.bucket().file("collections-bundle");
  try {
    const exists = await file.exists();
    if (exists) {
      const result = await file.download();
      const buffer = result[0];   
      {{#max_age}}
      res.set('Cache-Control', 'public, max-age={{max_age}}, s-maxage={{max_age}}');
      {{/max_age}}
      res.set('Content-Type', 'application/octet-stream');
      res.set('Content-Disposition', 'attachment; filename="collections-bundle"');
      res.end(buffer);
    } else {
      res.status(404).send("Not Found");
    }
  } catch (error) {
    res.status(404).send(`Not Found - ${error}`);
  }
});
{{#graphql}}
const typeDefs = gql`
{{#collections}}
  type {{#pascal_case}}{{name}}{{/pascal_case}} {
    {{#fields}}
    {{#graphql_type}}
    {{name}}: {{graphql_type}}
    {{/graphql_type}}
    {{/fields}}
    {{#has_resolvers}}
    {{#resolvers}}
    {{#camel_case}}{{target}}{{/camel_case}}: {{#array}}[{{#pascal_case}}{{target}}{{/pascal_case}}]{{/array}}{{^array}}{{#pascal_case}}{{target}}{{/pascal_case}}{{/array}}
    {{/resolvers}}
    {{/has_resolvers}}
  }
{{/collections}}
  type Query {
    {{#collections}}    
    {{#camel_case}}{{name}}{{/camel_case}}: [{{#pascal_case}}{{name}}{{/pascal_case}}]
    {{#camel_case}}{{name}}{{/camel_case}}ById(id: ID!): {{#pascal_case}}{{name}}{{/pascal_case}}
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
    {{#camel_case}}{{name}}{{/camel_case}}ById: async (_: any, { id }: any) => {
      const doc = await db.collection("{{name}}").doc(id).get();
      if (doc.exists) {
        return { ...doc.data(), id: doc.id };
      } else {
        return null;
      }
    },
    {{/collections}}
  },
  {{#collections}}
  {{#has_resolvers}}
  {{#pascal_case}}{{name}}{{/pascal_case}}: {
    {{#resolvers}}
    {{#array}}
    {{#camel_case}}{{target}}{{/camel_case}}: async (parent: any) => {
      const docs = await db.collection("{{target}}").where("{{field}}", "==", parent.id).get();
      return docs.docs.map((doc: any) => ({ ...doc.data(), id: doc.id }));
    },
    {{/array}}
    {{^array}}
    {{#camel_case}}{{target}}{{/camel_case}}: async (parent: any) => {
      const doc = await db.collection("{{target}}").doc(parent.{{field}}).get();
      if (doc) {
        return { ...doc.data(), id: doc.id };
      } else {
        return null;
      }
    },
    {{/array}}
    {{/resolvers}}
  },
  {{/has_resolvers}}
  {{/collections}}
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
{{/graphql}}''';

const startKey = '// GENERATED_FUNCTIONS_START';
const endKey = '// GENERATED_FUNCTIONS_END';

class FunctionsGenerator extends GeneratorBase {
  FunctionsGenerator({
    required this.outFile,
    required this.collections,
    this.graphql = false,
    this.cors = false,
    this.rest = false,
    this.maxAge,
  });
  final List<Collection> collections;
  final File outFile;
  final int? maxAge;
  final bool graphql, cors, rest;

  @override
  String get template => _template;

  bool get hasBundles => true;

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
    final resolvers = <String, List<dynamic>>{};
    for (final collection in collections) {
      if (collection.fields.where((e) => e.type is DocumentField).isNotEmpty) {
        for (final field
            in collection.fields.where((e) => e.type is DocumentField)) {
          resolvers[collection.name] ??= [];
          resolvers[collection.name]!.add({
            "target": (field.type as DocumentField).collection,
            "field": field.name,
            'array': false,
          });
        }
      }
      if (collections
          .where((e) => e.fields.any((f) =>
              f.type is DocumentField &&
              (f.type as DocumentField).collection == collection.name))
          .isNotEmpty) {
        for (final col in collections) {
          for (final field in col.fields) {
            if (field.type is DocumentField &&
                (field.type as DocumentField).collection == collection.name) {
              resolvers[collection.name] ??= [];
              resolvers[collection.name]!.add({
                "target": col.name,
                "field": field.name,
                'array': true,
              });
            }
          }
        }
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
            "has_resolvers": resolvers[collection.name] != null,
            "resolvers": resolvers[collection.name] ?? [],
          }
      ],
      'graphql': graphql,
      'rest': rest,
      'cors': cors,
      'max_age': maxAge,
      'all_triggers': [
        for (final entry in triggers.entries)
          copyJson({
            'collection': entry.key,
            'triggers': entry.value,
          })
      ],
      "bundles": [
        for (final collection in collections)
          if (collection.bundle == true) {'name': collection.name}
      ],
    };
  }

  @override
  String render() {
    final result = super.render();
    outFile.check();
    final content = outFile.readAsStringSync();
    final prefix = imports(graphql: graphql, bundles: hasBundles);
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
      blob: (_) => 'String',
      dynamic: () => 'String',
      num: () => 'Float',
      option: (values) => 'String',
    );
    return base;
  }
}
