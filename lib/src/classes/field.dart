import 'package:freezed_annotation/freezed_annotation.dart';

import 'collection.dart';
import 'doc.dart';
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

extension FieldUtils on Field {
  Object? getValue(Doc doc) {
    final data = doc.toJson();
    if (data.containsKey(name)) {
      return data[name];
    }
    for (final key in previous ?? []) {
      if (data.containsKey(key)) {
        return data[name];
      }
    }
    return null;
  }

  String? getString(Doc doc) {
    final value = getValue(doc);
    if (value is String) return value;
    if (defaultValue is String) {
      return defaultValue as String;
    }
    return null;
  }

  int? getInt(Doc doc) {
    final value = getValue(doc);
    if (value is int) return value;
    if (defaultValue is int) {
      return defaultValue as int;
    }
    return null;
  }

  double? getDouble(Doc doc) {
    final value = getValue(doc);
    if (value is double) return value;
    if (defaultValue is double) {
      return defaultValue as double;
    }
    return null;
  }

  num? getNum(Doc doc) {
    final value = getValue(doc);
    if (value is num) return value;
    if (defaultValue is num) {
      return defaultValue as num;
    }
    return null;
  }

  bool? getBool(Doc doc) {
    final value = getValue(doc);
    if (value is bool) return value;
    if (defaultValue is bool) {
      return defaultValue as bool;
    }
    return null;
  }

  DateTime? getDate(Doc doc) {
    final value = getValue(doc);
    if (value is DateTime) return value;
    if (value != null) {
      final date = DateTime.tryParse(value.toString());
      if (date != null) return date;
    }
    if (defaultValue is DateTime) {
      return defaultValue as DateTime;
    }
    return null;
  }
}
