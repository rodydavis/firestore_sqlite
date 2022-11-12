import 'package:flutter_test/flutter_test.dart';

import 'client.dart';

void main() {
  final testClient = TestClient();

  test('test doc values', () {
    final doc = TestDoc(id: '', client: testClient);
    doc.setJson({'name': 'John Doe'});

    final name = doc.name;

    expect(name, 'John Doe');
  });

  test('test previous values', () {
    final doc = TestDoc(id: '', client: testClient);
    doc.setJson({'full_name': 'John Doe'});

    final name = doc.name;

    expect(name, 'John Doe');
  });

  test('test schema changes', () {
    final doc = TestDoc(id: '', client: testClient);
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
