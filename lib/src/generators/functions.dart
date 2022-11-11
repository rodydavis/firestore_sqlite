import 'dart:io';

import 'package:firestore_sqlite/firestore_sqlite.dart';

import '../classes/collection.dart';
import '../utils/file.dart';
import 'base.dart';

const _template = r'''import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp(functions.config().firebase);
const db = admin.firestore();

async function handelCollection(request: functions.https.Request, response: functions.Response<any>, collection: string) {
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
export const collection_{{#camel_case}}{{name}}{{/camel_case}} = functions.https.onRequest((request, response) => handelCollection(request, response, "{{name}}"));
{{/collections}}

/**
 * Generated firestore triggers
 */
{{#all_triggers}}
export const collection_{{collection}}_trigger = functions.firestore
  .document('{{collection}}/{docId}')
  .onDelete(async (snapshot, context) => { 
    const batch = db.batch();
    {{#triggers}}
    const {{collection}}Items = await db.collection("{{collection}}").where("{{field}}", "==", context.params.docId).get();
    for (const item of {{collection}}Items.docs) {
      batch.delete(item.ref);
    }
    {{/triggers}}
    await batch.commit();
   });
{{/all_triggers}}

''';

class FunctionsGenerator extends GeneratorBase {
  FunctionsGenerator({required this.outFile, required this.collections});
  final List<Collection> collections;
  final File outFile;

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
      'collections': collections,
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
    outFile.writeAsStringSync(result);
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
