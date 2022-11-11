import 'dart:convert';

import '../utils/json.dart';
import 'base.dart';

class JsonGenerator extends GeneratorBase {
  JsonGenerator({
    required this.args,
    this.pretty = false,
  });

  final bool pretty;

  @override
  final Map<String, Object?> args;

  @override
  String get template => '{{.}}';

  @override
  String render() {
    if (pretty) {
      return prettyPrintJson(args);
    } else {
      return jsonEncode(args);
    }
  }
}
