import 'package:freezed_annotation/freezed_annotation.dart';

import 'base.dart';

part 'field.freezed.dart';
part 'field.g.dart';

@freezed
class Field with _$Field {
  const factory Field({
    required String name,
    required String type,
    required String? description,
    required bool? required,
    required List<String>? previous,
    required String? collection,
    required List<String>? values,
  }) = _Field;

  factory Field.fromJson(Map<String, Object?> json) => _$FieldFromJson(json);
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

  String? getString(Doc doc, [String? fallback]) {
    final value = getValue(doc);
    if (value is String) return value;
    return fallback;
  }

  int? getInt(Doc doc, [int? fallback]) {
    final value = getValue(doc);
    if (value is int) return value;
    return fallback;
  }

  double? getDouble(Doc doc, [double? fallback]) {
    final value = getValue(doc);
    if (value is double) return value;
    return fallback;
  }

  num? getNum(Doc doc, [num? fallback]) {
    final value = getValue(doc);
    if (value is num) return value;
    return fallback;
  }

  bool? getBool(Doc doc, [bool? fallback]) {
    final value = getValue(doc);
    if (value is bool) return value;
    return fallback;
  }

  DateTime? getDate(Doc doc, [DateTime? fallback]) {
    final value = getValue(doc);
    if (value is DateTime) return value;
    if (value != null) {
      final date = DateTime.tryParse(value.toString());
      if (date != null) return date;
    }
    return fallback;
  }
}
