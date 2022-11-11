import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import {ApolloServer, gql} from "apollo-server-cloud-functions";

admin.initializeApp(functions.config().firebase);
const db = admin.firestore();

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
 * artist - 
 */
export const collectionArtist = functions.https.onRequest((req, res) => {
  return handelCollection(req, res, "artist");
});



const typeDefs = gql`
  type Artist {
    name: String
    id: ID!
    created: String
    updated: String
    deleted: Boolean!
  }
  type Query {
    artist: [Artist]
  }
`;

const resolvers = {
  Query: {
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

