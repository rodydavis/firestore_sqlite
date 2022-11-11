import 'package:firestore_sqlite/src/generators/json.dart';
import 'package:mustache_template/mustache_template.dart';
import 'package:mustache_recase/mustache_recase.dart' as mustache_recase;

import 'collection.dart';

abstract class GeneratorBase {
  String get template;

  Map<String, Object?> get args;

  String render() {
    final template = Template(this.template, htmlEscapeValues: false);
    final variables = {...args};
    variables["dart_type"] = (LambdaContext ctx) {
      return convertType(ctx.renderString());
    };
    variables.addAll(mustache_recase.cases);
    final result = template.renderString(variables);
    return result;
  }
}
