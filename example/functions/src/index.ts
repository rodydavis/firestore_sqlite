import * as functions from "firebase-functions";
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

/**
 * test_0 - Random collection 0
 */
export const collection_test0 = functions.https.onRequest((request, response) => handelCollection(request, response, "test_0"));
/**
 * test_1 - Random collection 1
 */
export const collection_test1 = functions.https.onRequest((request, response) => handelCollection(request, response, "test_1"));
/**
 * test_2 - Random collection 2
 */
export const collection_test2 = functions.https.onRequest((request, response) => handelCollection(request, response, "test_2"));
/**
 * test_3 - Random collection 3
 */
export const collection_test3 = functions.https.onRequest((request, response) => handelCollection(request, response, "test_3"));
/**
 * test_4 - Random collection 4
 */
export const collection_test4 = functions.https.onRequest((request, response) => handelCollection(request, response, "test_4"));

