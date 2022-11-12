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
 * album - Showcase of music
 */
export const collectionAlbum = functions.https.onRequest((req, res) => {
  return handelCollection(req, res, "album");
});
/**
 * album_track - Songs on an album
 */
export const collectionAlbumTrack = functions.https.onRequest((req, res) => {
  return handelCollection(req, res, "album_track");
});
/**
 * artist - People that like to make music
 */
export const collectionArtist = functions.https.onRequest((req, res) => {
  return handelCollection(req, res, "artist");
});
/**
 * song - Expression of art in music form
 */
export const collectionSong = functions.https.onRequest((req, res) => {
  return handelCollection(req, res, "song");
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
export const collectionSongTrigger = functions.firestore
  .document('song/{docId}')
  .onDelete(async (snapshot, context) => { 
    const docId = context.params.docId;
    const batch = db.batch();
    const albumTrackItems = await db.collection("album_track").where("song_id", "==", docId).get();
    for (const item of albumTrackItems.docs) {
      batch.delete(item.ref);
    }
    await batch.commit();
   });
export const collectionAlbumTrigger = functions.firestore
  .document('album/{docId}')
  .onDelete(async (snapshot, context) => { 
    const docId = context.params.docId;
    const batch = db.batch();
    const albumTrackItems = await db.collection("album_track").where("album_id", "==", docId).get();
    for (const item of albumTrackItems.docs) {
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
      res.set('Cache-Control', 'public, max-age=86400, s-maxage=86400');
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
const typeDefs = gql`
  type Album {
    title: String
    artist_id: String
    artwork: String
    id: ID!
    created: String
    updated: String
    deleted: Boolean
    artist: Artist
    albumTrack: [AlbumTrack]
  }
  type AlbumTrack {
    song_id: String
    album_id: String
    id: ID!
    created: String
    updated: String
    deleted: Boolean
    song: Song
    album: Album
  }
  type Artist {
    name: String
    id: ID!
    created: String
    updated: String
    deleted: Boolean
    album: [Album]
  }
  type Song {
    title: String
    id: ID!
    created: String
    updated: String
    deleted: Boolean
    albumTrack: [AlbumTrack]
  }
  type Query {
    album: [Album]
    albumById(id: ID!): Album
    albumTrack: [AlbumTrack]
    albumTrackById(id: ID!): AlbumTrack
    artist: [Artist]
    artistById(id: ID!): Artist
    song: [Song]
    songById(id: ID!): Song
  }
`;
const resolvers = {
  Query: {
    album: async () => {
      const docs = await db.collection("album").get();
      return docs.docs.map((doc: any) => ({ ...doc.data(), id: doc.id }));
    },
    albumById: async (_: any, { id }: any) => {
      const doc = await db.collection("album").doc(id).get();
      if (doc.exists) {
        return { ...doc.data(), id: doc.id };
      } else {
        return null;
      }
    },
    albumTrack: async () => {
      const docs = await db.collection("album_track").get();
      return docs.docs.map((doc: any) => ({ ...doc.data(), id: doc.id }));
    },
    albumTrackById: async (_: any, { id }: any) => {
      const doc = await db.collection("album_track").doc(id).get();
      if (doc.exists) {
        return { ...doc.data(), id: doc.id };
      } else {
        return null;
      }
    },
    artist: async () => {
      const docs = await db.collection("artist").get();
      return docs.docs.map((doc: any) => ({ ...doc.data(), id: doc.id }));
    },
    artistById: async (_: any, { id }: any) => {
      const doc = await db.collection("artist").doc(id).get();
      if (doc.exists) {
        return { ...doc.data(), id: doc.id };
      } else {
        return null;
      }
    },
    song: async () => {
      const docs = await db.collection("song").get();
      return docs.docs.map((doc: any) => ({ ...doc.data(), id: doc.id }));
    },
    songById: async (_: any, { id }: any) => {
      const doc = await db.collection("song").doc(id).get();
      if (doc.exists) {
        return { ...doc.data(), id: doc.id };
      } else {
        return null;
      }
    },
  },
  Album: {
    artist: async (parent: any) => {
      const doc = await db.collection("artist").doc(parent.artist_id).get();
      if (doc) {
        return { ...doc.data(), id: doc.id };
      } else {
        return null;
      }
    },
    albumTrack: async (parent: any) => {
      const docs = await db.collection("album_track").where("album_id", "==", parent.id).get();
      return docs.docs.map((doc: any) => ({ ...doc.data(), id: doc.id }));
    },
  },
  AlbumTrack: {
    song: async (parent: any) => {
      const doc = await db.collection("song").doc(parent.song_id).get();
      if (doc) {
        return { ...doc.data(), id: doc.id };
      } else {
        return null;
      }
    },
    album: async (parent: any) => {
      const doc = await db.collection("album").doc(parent.album_id).get();
      if (doc) {
        return { ...doc.data(), id: doc.id };
      } else {
        return null;
      }
    },
  },
  Artist: {
    album: async (parent: any) => {
      const docs = await db.collection("album").where("artist_id", "==", parent.id).get();
      return docs.docs.map((doc: any) => ({ ...doc.data(), id: doc.id }));
    },
  },
  Song: {
    albumTrack: async (parent: any) => {
      const docs = await db.collection("album_track").where("song_id", "==", parent.id).get();
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
