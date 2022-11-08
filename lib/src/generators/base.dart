import 'package:flutter/foundation.dart';
import 'package:mustache_template/mustache_template.dart';

abstract class GeneratorBase {
  String get template;

  String render([Map<String, Object?> args = const {}]) {
    final template = Template(this.template, htmlEscapeValues: false);
    final result = template.renderString(args);
    debugPrint('GeneratorBase render: $result');
    return result;
  }
}
