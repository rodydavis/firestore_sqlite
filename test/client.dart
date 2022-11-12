import 'dart:convert';
import 'dart:io';

import 'package:firestore_sqlite/firestore_sqlite.dart';

class TestClient extends FirestoreClient {
  @override
  List<Collection> get collections => [
        testCollection,
      ];

  late final test = FirestoreClientCollection(this, testCollection);
}

class LocalClient extends FirestoreClient {
  LocalClient(this.collections);

  @override
  final List<Collection> collections;

  factory LocalClient.fromSchema() {
    final schemaFile = File('.example/schema.json');
    final items = jsonDecode(schemaFile.readAsStringSync()) as List;
    final collections = items.map((e) => Collection.fromJson(e)).toList();
    return LocalClient(collections);
  }
}

final testCollection = Collection.fromJson(const {
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
