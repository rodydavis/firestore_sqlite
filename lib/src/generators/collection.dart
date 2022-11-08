import 'dart:convert';

import 'package:dart_style/dart_style.dart';
import 'package:firestore_sqlite/firestore_sqlite.dart';
import 'package:mustache_template/mustache_template.dart';

import 'base.dart';

const _template = r'''import 'package:firestore_sqlite/firestore_sqlite.dart';

/// {{description}}
class {{#pascal_case}}{{name}}{{/pascal_case}} extends Doc {
  {{#pascal_case}}{{name}}{{/pascal_case}}({required super.id})
    : super(
        collection: Collection.fromJson(const {
          "name": "{{name}}",
          "created": "{{created}}",
          "updated": "{{updated}}",
          "description": "{{description}}",
          "fields": [
            {{#fields}}
            {{#json_field}}{{name}}{{/json_field}},
            {{/fields}}
          ],
        }),
      );

  @override
  DateTime get created => this['created'] as DateTime;

  @override
  DateTime get updated => this['updated'] as DateTime;

  @override
  bool? get deleted => this['deleted'] as bool?;

  {{#fields}}
  /// {{description}}
  {{#dart_type}}{{type.runtimeType}}{{/dart_type}}? get {{name}} => this['{{name}}'] as {{#dart_type}}{{type.runtimeType}}{{/dart_type}}?;
  set {{name}}({{#dart_type}}{{type.runtimeType}}{{/dart_type}}? value) => this['{{name}}'] = value;
  {{/fields}}
}
''';

class CollectionGenerator extends GeneratorBase {
  CollectionGenerator(this.collection);

  final Collection collection;

  @override
  Map<String, Object?> get args {
    final variables = copyJson(collection) as Map<String, Object?>;
    variables["json_field"] = (LambdaContext ctx) {
      final key = ctx.renderString();
      final fields = collection.allFields;
      final field = fields.firstWhere((e) => e.keys.contains(key));
      return prettyPrintJson(copyJson(field));
    };
    return variables;
  }

  @override
  String get template => _template;

  @override
  String render() {
    final result = super.render();
    final formatter = DartFormatter();
    return formatter.format(result);
  }
}

String convertType(String value) {
  switch (value) {
    case 'date':
      return 'DateTime';
    case 'string':
      return 'String';
    case 'int':
      return 'int';
    case 'num':
      return 'num';
    case 'double':
      return 'double';
    case 'bool':
      return 'bool';
    default:
      break;
  }
  return 'Object';
}
