import 'package:firestore_sqlite/firestore_sqlite.dart';

import "collections/album.dart";
import "collections/album_track.dart";
import "collections/artist.dart";
import "collections/song.dart";

export "collections/album.dart";
export "collections/album_track.dart";
export "collections/artist.dart";
export "collections/song.dart";

class Client extends NativeClient {
  @override
  List<Collection> get collections => [
        albumCollection,
        albumTrackCollection,
        artistCollection,
        songCollection,
      ];

  /// Showcase of music
  late final album = FirestoreClientCollection(this, albumCollection);

  /// Songs on an album
  late final albumTrack = FirestoreClientCollection(this, albumTrackCollection);

  /// People that like to make music
  late final artist = FirestoreClientCollection(this, artistCollection);

  /// Expression of art in music form
  late final song = FirestoreClientCollection(this, songCollection);
}
