import 'package:freezed_annotation/freezed_annotation.dart';

import 'field.dart';
import 'type.dart';

part 'collection.freezed.dart';
part 'collection.g.dart';

typedef Json = Map<String, dynamic>;

@freezed
class Collection with _$Collection {
  const factory Collection({
    required String name,
    required DateTime created,
    required DateTime updated,
    required String? description,
    required List<Field> fields,
  }) = _Collection;

  factory Collection.fromJson(Json json) => _$CollectionFromJson(json);
}

extension CollectionX on Collection {
  static Field get idField => const Field(
        name: 'id',
        type: StringField(),
        required: true,
      );
  static Field get createdField => const Field(
        name: 'created',
        type: DateField(),
        required: true,
      );
  static Field get updatedField => const Field(
        name: 'updated',
        type: DateField(),
        required: true,
      );
  static Field get deletedField => const Field(
        name: 'deleted',
        type: BoolField(),
      );

  static List<Field> get defaultFields => [
        idField,
        createdField,
        updatedField,
        deletedField,
      ];

  List<Field> get allFields {
    final result = fields.toList();
    final keys = fields.map((e) => e.name).toList();
    if (!keys.contains('id')) result.add(idField);
    if (!keys.contains('updated')) result.add(updatedField);
    if (!keys.contains('updated')) result.add(updatedField);
    if (!keys.contains('deleted')) result.add(deletedField);
    return result;
  }
}
