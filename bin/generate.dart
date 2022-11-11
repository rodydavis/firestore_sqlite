// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:firestore_sqlite/src/classes/collection.dart';
import 'package:firestore_sqlite/src/generators/client.dart';
import 'package:firestore_sqlite/src/generators/functions.dart';

Future<void> main(List<String> args) async {
  final parser = ArgParser();
  parser.addOption(
    'schema',
    abbr: 's',
    help: 'Path to schema file',
  );
  parser.addOption(
    'generated',
    abbr: 'g',
    help: 'Path to output directory',
    defaultsTo: 'lib/generated',
  );
  parser.addOption(
    'functions',
    abbr: 'f',
    help: 'Path to functions file',
    defaultsTo: 'functions/src/index.ts',
  );

  final results = parser.parse(args);
  final schemaPath = results['schema'];
  if (schemaPath == null || schemaPath.isEmpty) {
    print('Missing schema file: -s <path>');
    return;
  }
  final outputPath = results['generated'] ?? '';
  final functionsPath = results['functions'] ?? '';

  final schema = File(schemaPath).readAsStringSync();
  final docs = jsonDecode(schema) as List;
  final collections = docs.map((e) => Collection.fromJson(e)).toList();
  if (outputPath.isNotEmpty) {
    ClientGenerator(
      output: Directory(outputPath),
      collections: collections,
    ).render();
  }
  if (functionsPath.isNotEmpty) {
    FunctionsGenerator(
      graphql: true,
      cors: true,
      collections: collections,
      outFile: File(functionsPath),
    ).render();
  }
}
