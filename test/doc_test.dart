import 'package:flutter_test/flutter_test.dart';

import 'package:firestore_sqlite/firestore_sqlite.dart';

class TestDoc extends Doc {
  TestDoc({required super.id})
      : super(
          collection: Collection.fromJson(const {
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
          }),
        );

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

void main() {
  test('test doc values', () {
    final doc = TestDoc(id: '');
    doc.setJson({'name': 'John Doe'});

    final name = doc.name;

    expect(name, 'John Doe');
  });

  test('test previous values', () {
    final doc = TestDoc(id: '');
    doc.setJson({'full_name': 'John Doe'});

    final name = doc.name;

    expect(name, 'John Doe');
  });

  test('test schema changes', () {
    final doc = TestDoc(id: '');
    doc.setJson({'name': 'John Doe'});

    expect(doc['display_name'], null);

    doc.setSchema({
      "name": "test",
      "created": "1970-01-01T00:00:00.000",
      "updated": "1970-01-01T00:00:00.000",
      "description": "Test class generation",
      "fields": [
        {
          "name": "display_name",
          "type": {"maxLength": null, "runtimeType": "string"},
          "description": "Display name",
          "required": null,
          "defaultValue": null,
          "previous": ['full_name', 'name']
        },
      ],
    });

    expect(doc['display_name'], 'John Doe');
  });
}
