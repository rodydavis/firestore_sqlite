import 'package:mustache_template/mustache_template.dart';

import '../classes/collection.dart';
import '../classes/field.dart';
import '../utils/json.dart';
import 'base.dart';
import '../utils/format.dart';

const _template = r'''import 'package:firestore_sqlite/firestore_sqlite.dart';

/// {{description}}
final {{#camel_case}}{{name}}{{/camel_case}}Collection = Collection.fromJson(const {
  "name": "{{name}}",
  "created": "{{created}}",
  "updated": "{{updated}}",
  "description": "{{description}}",
  {{#bundle}}"bundle": {{bundle}},{{/bundle}}
  "fields": [
    {{#all_fields}}
    {{#json_field}}{{name}}{{/json_field}},
    {{/all_fields}}
  ],
});

/// {{description}}
class {{#pascal_case}}{{name}}{{/pascal_case}} extends Doc {
  {{#pascal_case}}{{name}}{{/pascal_case}}({required super.id})
    : super(collection: {{#camel_case}}{{name}}{{/camel_case}}Collection);

  @override
  DateTime get created => this['created'] as DateTime;

  @override
  DateTime get updated => this['updated'] as DateTime;

  @override
  bool? get deleted => this['deleted'] as bool?;

  {{#fields}}
  /// {{description}}
  {{#dart_type}}{{type.runtimeType}}{{/dart_type}}? get {{#camel_case}}{{name}}{{/camel_case}} => this['{{name}}'] as {{#dart_type}}{{type.runtimeType}}{{/dart_type}}?;
  set {{#camel_case}}{{name}}{{/camel_case}}({{#dart_type}}{{type.runtimeType}}{{/dart_type}}? value) => this['{{name}}'] = value;
  {{/fields}}
}
''';

class CollectionGenerator extends GeneratorBase {
  CollectionGenerator(this.collection);

  final Collection collection;

  @override
  Map<String, Object?> get args {
    final allFields = collection.fields.toList();
    final fields = collection.fields
        .where((f) =>
            !CollectionX.defaultFields.map((e) => e.name).contains(f.name))
        .toList();
    final col = collection.copyWith(fields: fields);
    final variables = copyJson(col) as Map<String, Object?>;
    variables['all_fields'] = copyJson(allFields);
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
    return formatDart(result);
  }
}

String convertType(String value) {
  switch (value) {
    case 'date':
      return 'DateTime';
    case 'string':
    case 'document':
    case 'blob':
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
