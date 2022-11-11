import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'firebase_options.dart';

Future<void> initFirebase({
  bool emulators = false,
  FirebaseFirestore? firestore,
  FirebaseStorage? storage,
}) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (emulators) {
    const host = '127.0.0.1';
    (firestore ?? FirebaseFirestore.instance).useFirestoreEmulator(host, 8080);
    (storage ?? FirebaseStorage.instance).useStorageEmulator(host, 9199);
  }
}
