import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'package:firestore_sqlite/firestore_sqlite.dart';

const _classTest = r'''import 'package:firestore_sqlite/firestore_sqlite.dart';

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
      "previous": null
    },
  ],
});

/// Test class generation
class Test extends Doc {
  Test({required super.id}) : super(collection: testCollection);

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

  test('client generator', () {
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
    final client = ClientGenerator(
      collections: [collection],
      output: Directory('./generated'),
    );

    client.render();

    expect(client.collections.length, 1);
  });

  test('functions generator', () {
    final outFile = File('./test/functions.ts');

    final client = FunctionsGenerator(
      collections: List.generate(
        5,
        (index) => Collection(
          name: 'test_$index',
          created: DateTime(1970),
          updated: DateTime(1970),
          description: 'Random collection $index',
          fields: [
            const Field(
              name: 'name',
              type: StringField(),
              description: 'Display name',
            ),
            if (index == 2)
              const Field(
                name: 'test_id',
                type: DocumentField(
                  'test_1',
                  triggerDelete: true,
                ),
                description: 'Test reference',
              ),
          ],
        ),
      ),
      outFile: outFile,
    );

    client.render();

    expect(client.collections.length, 5);
    expect(outFile.existsSync(), true);

    outFile.deleteSync();
  });

  test('schema generator', () {
    final outFile = File('./test/schema.json');

    final client = SchemaGenerator(
      collections: List.generate(
        5,
        (index) => Collection(
          name: 'test_$index',
          created: DateTime(1970),
          updated: DateTime(1970),
          description: 'Random collection $index',
          fields: const [
            Field(
              name: 'name',
              type: StringField(),
              description: 'Display name',
            ),
          ],
        ),
      ),
      outFile: outFile,
    );

    client.render();

    expect(client.collections.length, 5);
    expect(outFile.existsSync(), true);

    outFile.deleteSync();
  });
}
