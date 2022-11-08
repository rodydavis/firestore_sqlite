import 'dart:convert';
import 'dart:io';

import 'package:firestore_sqlite/src/generators/client.dart';
import 'package:firestore_sqlite/src/classes/collection.dart';

Future<void> main(List<String> args) async {
  final schema = File('./bin/schema.json').readAsStringSync();
  final docs = jsonDecode(schema) as List;
  final collections = docs.map((e) => Collection.fromJson(e)).toList();
  final generator = ClientGenerator(
    output: Directory('./lib/generated'),
    collections: collections,
  );
  generator.render();
}
