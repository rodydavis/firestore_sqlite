import 'dart:io';

import '../classes/collection.dart';
import '../utils/file.dart';
import '../utils/json.dart';
import 'base.dart';
import 'json.dart';

class SchemaGenerator extends GeneratorBase {
  SchemaGenerator({required this.outFile, required this.collections});
  final List<Collection> collections;
  final File outFile;

  @override
  String get template => '{{.}}';

  @override
  Map<String, Object?> get args => {};

  @override
  String render() {
    final result = prettyPrintJson(collections);
    outFile.check();
    outFile.writeAsStringSync(result);
    return result;
  }
}
