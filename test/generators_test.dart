import 'package:flutter_test/flutter_test.dart';

import 'package:firestore_sqlite/firestore_sqlite.dart';

const _classTest = r'''import 'package:firestore_sqlite/firestore_sqlite.dart';

/// Test class generation
class Test extends Doc {
  Test({required super.id})
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
                "previous": null
              },
            ],
          }),
        );

  @override
  DateTime get created => this['created'] as DateTime;

  @override
  DateTime get updated => this['updated'] as DateTime;

  @override
  bool? get deleted => this['deleted'] as bool?;

  /// Display name
  String? get name => this['name'] as String?;
  set name(String? value) => this['name'] = value;
}

''';

void main() {
  test('json generator', () {
    final args = {'key': 'value'};

    final generator = JsonGenerator(args: args);
    final result = generator.render();

    expect(result, '{"key":"value"}');
  });

  test('collection generator', () {
    final collection = Collection(
      name: 'test',
      created: DateTime(1970),
      updated: DateTime(1970),
      description: 'Test class generation',
      fields: const [
        Field(
          name: 'name',
          type: StringField(),
          description: 'Display name',
        ),
      ],
    );

    final generator = CollectionGenerator(collection);
    final result = generator.render();

    expect(result.trim(), _classTest.trim());
  });
}
