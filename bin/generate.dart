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
    defaultsTo: 'schema.json',
  );
  parser.addOption(
    'output',
    abbr: 'o',
    help: 'Output directory',
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
  parser.addFlag(
    'graphql',
    abbr: 'q',
    help: 'Generate GraphQL',
  );
  parser.addFlag(
    'rest',
    abbr: 'r',
    help: 'Generate Rest API',
  );
  parser.addFlag(
    'cors',
    abbr: 'c',
    help: 'Generate CORS',
  );

  final results = parser.parse(args);
  Directory.current = Directory(results['output'] ?? Directory.current.path);

  final schemaPath = results['schema'];
  final buildGraphQl = results['graphql'] ?? false;
  final buildRest = results['rest'] ?? false;
  final buildCors = results['cors'] ?? false;
  final outputPath = results['generated'] ?? '';
  final functionsPath = results['functions'] ?? '';

  final schemaFile = File(schemaPath);
  if (!schemaFile.existsSync()) {
    print('Missing schema file: -s <path>');
    return;
  }
  final schema = schemaFile.readAsStringSync();
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
      graphql: buildGraphQl,
      cors: buildCors,
      rest: buildRest,
      collections: collections,
      outFile: File(functionsPath),
    ).render();
  }
}
