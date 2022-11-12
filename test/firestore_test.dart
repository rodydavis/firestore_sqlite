import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_sqlite/firestore_sqlite.dart';
import 'package:flutter_test/flutter_test.dart';

import 'client.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final testClient = TestClient();

  test('test collection', () async {
    final ref = testClient.test.collection.getSchema(testClient);
    await ref.set(testClient.test.collection.toMap());

    final doc = await ref.get();
    final data = doc.toJson();

    expect(data['id'], testClient.test.collection.name);
    expect(data['name'], testClient.test.collection.name);
  });

  test('test local edit', () async {
    const docId = 'test-doc';
    final docData = {
      'id': docId,
      'name': 'John Doe',
      'collection': testCollection.name,
      'created': DateTime.now().toIso8601String(),
      'updated': DateTime.now().toIso8601String(),
    };

    // Set schema
    final col = testClient.test.collection;
    final ref = col.getSchema(testClient);
    await ref.set(col.toMap());
    final reference = ref.collection(col.name);
    final doc = reference.doc(docId);

    // Make sure doc does not exist locally
    final test1 = await testClient.test.getSingle(
      docId,
      options: const GetOptions(source: Source.cache),
    );
    expect(test1 == null, true);

    // Add doc locally
    await testClient.database.insertOrReplaceDocument(docData);

    // Make sure doc exists locally
    final test2 = await testClient.test.getSingle(
      docId,
      options: const GetOptions(source: Source.cache),
    );
    expect(test2 != null, true);

    // Check if does not exists on remote
    final test3 = await doc.get();
    expect(test3.exists, false);

    await testClient.test.sync(reference);

    // Check if exists on remote
    final test4 = await doc.get();
    expect(test4.exists, true);
  });
}
