import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firestore_sqlite/firestore_sqlite.dart';
import 'package:flutter/foundation.dart';

abstract class NativeClient extends FirestoreClient {
  @override
  Firebase firebase = Firebase(
    firestore: FirebaseFirestore.instance,
    storage: FirebaseStorage.instance,
  );

  @override
  Database database = Database.defaults(
    logStatements: kDebugMode,
  );
}
