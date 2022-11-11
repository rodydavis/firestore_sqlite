import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {ApolloServer, gql} from "apollo-server-cloud-functions";

admin.initializeApp(functions.config().firebase);
const db = admin.firestore();
const storage = admin.storage();

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
/**
 * album - Albums by an artist
 */
export const collectionAlbum = functions.https.onRequest((req, res) => {
  return handelCollection(req, res, "album");
});
/**
 * artist - 
 */
export const collectionArtist = functions.https.onRequest((req, res) => {
  return handelCollection(req, res, "artist");
});
export const collectionArtistTrigger = functions.firestore
  .document('artist/{docId}')
  .onDelete(async (snapshot, context) => { 
    const docId = context.params.docId;
    const batch = db.batch();
    const albumItems = await db.collection("album").where("artist_id", "==", docId).get();
    for (const item of albumItems.docs) {
      batch.delete(item.ref);
    }
    await batch.commit();
   });
export const uploadBundle = functions.https.onRequest(async (req, res) => {
  const bundle = db.bundle("collections-bundle");
  const schema = await db.collection("schema").get();
  bundle.add('schema', schema);
  const album = await db.collection("album").get();
  bundle.add('album', album);
  const artist = await db.collection("artist").get();
  bundle.add('artist', artist);
  const buffer = bundle.build();
  await storage.bucket().file("collections-bundle").save(buffer);
  res.send(buffer);
});
export const downloadBundle = functions.https.onRequest(async (req, res) => {
  const buffer = await storage.bucket().file("collections-bundle").download();
  if (buffer) {
    res.send(buffer);
  } else {
    res.status(404).send("Not Found");
  }
});
const typeDefs = gql`
  type Album {
    artistId: String
    title: String
    id: ID!
    created: String
    updated: String
    deleted: Boolean!
  }
  type Artist {
    name: String!
    description: String!
    age: Float!
    alive: Boolean!
    id: ID!
    created: String
    updated: String
    deleted: Boolean!
  }
  type Query {
    album: [Album]
    artist: [Artist]
  }
`;
const resolvers = {
  Query: {
    album: async () => {
      const docs = await db.collection("album").get();
      return docs.docs.map((doc: any) => ({ ...doc.data(), id: doc.id }));
    },
    artist: async () => {
      const docs = await db.collection("artist").get();
      return docs.docs.map((doc: any) => ({ ...doc.data(), id: doc.id }));
    },
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
  const handler = server.createHandler({
    // @ts-ignore
    cors: { origin: true, credentials: true },
  });
  return handler(req, res, () => { });
});
