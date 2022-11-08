import 'package:firestore_sqlite/firestore_sqlite.dart';

import "collections/albums.dart";
import "collections/artists.dart";

class Client extends FirestoreClient {
  // albums - Artwork by an artist
  Collection get albums => albumsCollection;
  Future<List<Doc>> getAlbumss() => getDocs(albums);
  Stream<List<Doc>> watchAlbumss() => watchDocs(albums);
  Future<Doc?> getAlbums(String id) => getDoc(albums, id);
  Stream<Doc?> watchAlbums(String id) => watchDoc(albums, id);
  // artists - People that like to make music
  Collection get artists => artistsCollection;
  Future<List<Doc>> getArtistss() => getDocs(artists);
  Stream<List<Doc>> watchArtistss() => watchDocs(artists);
  Future<Doc?> getArtists(String id) => getDoc(artists, id);
  Stream<Doc?> watchArtists(String id) => watchDoc(artists, id);
}
