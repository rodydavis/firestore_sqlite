import 'package:firestore_sqlite/src/classes/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

import 'client.dart';
import 'database/database.dart';

class AdminClient extends FirestoreClient {
  @override
  Firebase firebase = Firebase(
    firestore: FirebaseFirestore.instance,
    storage: FirebaseStorage.instance,
  );

  @override
  Database database = Database.defaults(
    logStatements: kDebugMode,
  );

  @override
  List<Collection> get collections => [];
}
