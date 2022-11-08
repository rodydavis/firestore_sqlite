import 'package:flutter/foundation.dart';
import 'package:mustache_template/mustache_template.dart';
import 'package:mustache_recase/mustache_recase.dart' as mustache_recase;

abstract class GeneratorBase {
  String get template;

  Map<String, Object?> get args;

  String render() {
    final template = Template(this.template, htmlEscapeValues: false);
    final variables = {...args};
    variables.addAll(mustache_recase.cases);
    final result = template.renderString(variables);
    debugPrint('GeneratorBase render: $result');
    return result;
  }
}
