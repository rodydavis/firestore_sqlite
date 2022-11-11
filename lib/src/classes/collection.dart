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
    bool? bundle,
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
    if (!keys.contains('created')) result.add(createdField);
    if (!keys.contains('updated')) result.add(updatedField);
    if (!keys.contains('deleted')) result.add(deletedField);
    return result;
  }

  List<Field> get restFields {
    return allFields.where((e) => !defaultFields.contains(e)).toList();
  }

  ValidationResult validate(Json data) {
    final result = ValidationResult();
    for (final field in allFields) {
      final value = data[field.name];
      final required = field.required ?? false;
      if (required && value == null) {
        result.addError(field.name, 'required');
      } else {
        field.type.when(
          string: (maxLength) {
            if (value is! String) {
              result.addError(field.name, 'invalid type');
            } else if (maxLength != null && value.length > maxLength) {
              result.addError(field.name, 'too long');
            }
          },
          int: () {
            if (!required && value != null && value is! int) {
              result.addError(field.name, 'invalid type');
            }
          },
          num: () {
            if (!required && value != null && value is! num) {
              result.addError(field.name, 'invalid type');
            }
          },
          double: () {
            if (!required && value != null && value is! double) {
              result.addError(field.name, 'invalid type');
            }
          },
          bool: () {
            if (!required && value != null && value is! bool) {
              result.addError(field.name, 'invalid type');
            }
          },
          map: () {
            if (!required && value != null && value is! Map) {
              result.addError(field.name, 'invalid type');
            }
          },
          array: () {
            if (!required && value != null && value is! List) {
              result.addError(field.name, 'invalid type');
            }
          },
          blob: (bucket) {
            if (!required && value != null && value is! String) {
              result.addError(field.name, 'invalid type');
            }
          },
          option: (values) {
            if (!required && value != null && value is! String) {
              result.addError(field.name, 'invalid type');
            } else if (!values.contains(value)) {
              result.addError(field.name, 'invalid value');
            }
          },
          date: () {
            if (!required && value != null && value is! DateTime) {
              result.addError(field.name, 'invalid type');
            }
          },
          document: (collection, triggerDelete) {
            if (!required && value != null && value is! Map) {
              result.addError(field.name, 'invalid type');
            }
          },
          dynamic: () {},
        );
      }
    }
    return result;
  }
}

class ValidationResult {
  ValidationResult();

  bool get valid => errors.isEmpty;
  final List<String> errors = [];

  void addError(String field, String error) {
    errors.add('$field: $error');
  }

  @override
  String toString() {
    return 'ValidationResult{valid: $valid, errors: $errors';
  }
}
