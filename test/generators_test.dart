import 'package:flutter_test/flutter_test.dart';

import 'package:firestore_sqlite/firestore_sqlite.dart';

void main() {
  test('check json generation', () {
    final generator = JsonGenerator();

    final result = generator.render({'key': 'value'});

    expect(result, '{"key":"value"}');
  });
}
