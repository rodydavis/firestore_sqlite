import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> initFirebase([bool emulators = false]) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (emulators) {
    const host = '127.0.0.1';
    FirebaseFirestore.instance.useFirestoreEmulator(host, 8080);
  }
}
