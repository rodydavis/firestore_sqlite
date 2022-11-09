import 'package:firestore_sqlite/firestore_sqlite.dart';

import "collections/albums.dart";
import "collections/artists.dart";

class Client extends FirestoreClient {
  // Artwork by an artist
  final albums = FirestoreClientCollection(albumsCollection);
  // People that like to make music
  final artists = FirestoreClientCollection(artistsCollection);
}
