import 'dart:io';

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

''';

class FunctionsGenerator extends GeneratorBase {
  FunctionsGenerator({required this.outFile, required this.collections});
  final List<Collection> collections;
  final File outFile;

  @override
  String get template => _template;

  @override
  Map<String, Object?> get args => {
        'collections': collections.map((e) => e.toJson()).toList(),
      };

  @override
  String render() {
    final result = super.render();
    outFile.check();
    outFile.writeAsStringSync(result);
    return result;
  }
}
