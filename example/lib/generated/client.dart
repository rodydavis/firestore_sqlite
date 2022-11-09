import 'package:firestore_sqlite/firestore_sqlite.dart';

import "collections/artist.dart";

export "collections/artist.dart";

class Client extends FirestoreClient {
  ///
  late final artist = FirestoreClientCollection(this, artistCollection);
}
