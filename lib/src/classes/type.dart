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
  const factory FieldType.map() = MapField;
  const factory FieldType.array() = ListField;
  const factory FieldType.blob(String bucket) = BlobField;
  const factory FieldType.option(List<String> values) = OptionField;
  const factory FieldType.date() = DateField;
  const factory FieldType.document(String collection) = DocumentField;
  const factory FieldType.dynamic() = DynamicField;

  factory FieldType.fromJson(Json json) => _$FieldTypeFromJson(json);
}
