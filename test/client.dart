import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_storage_mocks/firebase_storage_mocks.dart';
import 'package:firestore_sqlite/firestore_sqlite.dart';

final testDatabase = Database(
  connection: DatabaseConnection(
    NativeDatabase.memory(
      logStatements: true,
    ),
  ),
);

class MockFirebase extends Firebase {
  MockFirebase()
      : super(
          firestore: FakeFirebaseFirestore(),
          storage: MockFirebaseStorage(),
        );
}

class TestClient extends FirestoreClient {
  @override
  Firebase get firebase => MockFirebase();

  @override
  List<Collection> get collections => [testCollection];

  @override
  Database get database => testDatabase;

  late final test =
      FirestoreClientCollection(this, testCollection, (doc) => doc);
}

class LocalClient extends TestClient {
  LocalClient(this.collections);

  @override
  final List<Collection> collections;

  factory LocalClient.fromSchema() {
    final schemaFile = File('./test/schema.json');
    final items = jsonDecode(schemaFile.readAsStringSync()) as List;
    final collections = items.map((e) => Collection.fromJson(e)).toList();
    return LocalClient(collections);
  }
}

final testCollection = Collection.fromJson(const {
  "id": "test",
  "name": "test",
  "created": "1970-01-01T00:00:00.000",
  "updated": "1970-01-01T00:00:00.000",
  "description": "Test class generation",
  "fields": [
    {
      "name": "name",
      "type": {"maxLength": null, "runtimeType": "string"},
      "description": "Display name",
      "required": null,
      "defaultValue": null,
      "previous": ['full_name']
    },
  ],
});

class TestDoc extends Doc {
  TestDoc({required super.id, required super.client})
      : super(collection: testCollection);

  @override
  DateTime get created => this['created'] as DateTime;
  set created(DateTime value) => this['created'] = value;

  @override
  DateTime get updated => this['updated'] as DateTime;

  @override
  bool? get deleted => this['deleted'] as bool?;

  /// Display name
  String? get name => this['name'] as String?;
  set name(String? value) => this['name'] = value;
}
