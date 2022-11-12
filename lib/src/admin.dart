import 'package:firestore_sqlite/src/classes/collection.dart';

import 'client.dart';

class AdminClient extends FirestoreClient {
  @override
  List<Collection> get collections => [];
}

final admin = AdminClient();
