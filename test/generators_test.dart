import 'dart:convert';
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
  final schemaFile = File('example/bin/schema.json');
  final items = jsonDecode(schemaFile.readAsStringSync()) as List;
  final collections = items.map((e) => Collection.fromJson(e)).toList();

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
    final client = ClientGenerator(
      collections: collections,
      output: Directory('./example/lib/generated'),
    );

    client.render();

    expect(client.collections.length, 1);
  });

  test('functions generator', () {
    final outFile = File('./example/functions/src/index.ts');

    final client = FunctionsGenerator(
      graphql: true,
      cors: true,
      collections: collections,
      outFile: outFile,
    );

    client.render();

    expect(client.collections.length, 1);
    expect(outFile.existsSync(), true);

    // outFile.deleteSync();
  });

  test('schema generator', () {
    final outFile = File('./test/schema.json');

    final client = SchemaGenerator(
      collections: collections,
      outFile: outFile,
    );

    client.render();

    expect(client.collections.length, 5);
    expect(outFile.existsSync(), true);

    // outFile.deleteSync();
  });
}
