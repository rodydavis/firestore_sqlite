import 'package:freezed_annotation/freezed_annotation.dart';

import 'collection.dart';

part 'type.freezed.dart';
part 'type.g.dart';

@freezed
class FieldType with _$FieldType {
  const factory FieldType.string({int? maxLength}) = StringField;
  const factory FieldType.int() = IntField;
  const factory FieldType.num() = NumField;
  const factory FieldType.double() = DoubleField;
  const factory FieldType.bool() = BoolField;
  // const factory FieldType.map() = MapField;
  // const factory FieldType.array() = ListField;
  const factory FieldType.blob(String bucket) = BlobField;
  const factory FieldType.option(List<String> values) = OptionField;
  const factory FieldType.date() = DateField;
  const factory FieldType.document(String collection, {bool? triggerDelete}) =
      DocumentField;
  const factory FieldType.dynamic() = DynamicField;

  factory FieldType.fromJson(Json json) => _$FieldTypeFromJson(json);
}

extension FieldTypeUtils on FieldType {
  String get typeInfo => when(
        string: (_) => 'string',
        int: () => 'int',
        num: () => 'num',
        double: () => 'double',
        bool: () => 'bool',
        blob: (_) => 'blob',
        option: (_) => 'option',
        date: () => 'date',
        document: (_, __) => 'document',
        dynamic: () => 'dynamic',
      );
}

final List<String> fieldTypes = [
  'string',
  'int',
  'num',
  'double',
  'bool',
  'blob',
  'option',
  'date',
  'document',
  'dynamic',
];

FieldType parseFieldType(String type) {
  switch (type) {
    case 'string':
      return const FieldType.string();
    case 'int':
      return const FieldType.int();
    case 'num':
      return const FieldType.num();
    case 'double':
      return const FieldType.double();
    case 'bool':
      return const FieldType.bool();
    case 'blob':
      return const FieldType.blob('');
    case 'option':
      return const FieldType.option([]);
    case 'date':
      return const FieldType.date();
    case 'document':
      return const FieldType.document('');
    case 'dynamic':
      return const FieldType.dynamic();
    default:
      throw Exception('Unknown field type: $type');
  }
}
