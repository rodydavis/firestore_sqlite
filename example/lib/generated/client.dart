import 'package:firestore_sqlite/firestore_sqlite.dart';

import "collections/album.dart";
import "collections/artist.dart";

export "collections/album.dart";
export "collections/artist.dart";

class Client extends FirestoreClient {
  @override
  List<Collection> get collections => [
        albumCollection,
        artistCollection,
      ];

  /// Albums by an artist
  late final album = FirestoreClientCollection(this, albumCollection);

  ///
  late final artist = FirestoreClientCollection(this, artistCollection);
}
