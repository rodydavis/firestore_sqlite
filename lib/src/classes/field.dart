import 'package:freezed_annotation/freezed_annotation.dart';

import 'collection.dart';
import 'type.dart';

part 'field.freezed.dart';
part 'field.g.dart';

@freezed
class Field with _$Field {
  const factory Field({
    required String name,
    required FieldType type,
    String? description,
    bool? required,
    Object? defaultValue,
    List<String>? previous,
  }) = _Field;

  factory Field.fromJson(Json json) => _$FieldFromJson(json);
}

extension FieldX on Field {
  List<String> get keys => [name, ...previous ?? []];
}
