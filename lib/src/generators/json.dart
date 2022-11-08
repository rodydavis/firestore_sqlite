import 'dart:convert';

import 'base.dart';

class JsonGenerator extends GeneratorBase {
  JsonGenerator({
    this.pretty = false,
  });

  final bool pretty;

  @override
  String get template => '{{.}}';

  @override
  String render([Map<String, Object?> args = const {}]) {
    if (pretty) {
      const encoder = JsonEncoder.withIndent('  ');
      return encoder.convert(args);
    } else {
      return jsonEncode(args);
    }
  }
}
