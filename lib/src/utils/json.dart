import 'dart:convert';

String prettyPrintJson(Object data) {
  const encoder = JsonEncoder.withIndent('  ');
  return encoder.convert(copyJson(data));
}

String jsonToString(Map<String, Object?> data) {
  return jsonEncode(data);
}

Object copyJson(Object object) {
  return jsonDecode(jsonEncode(object));
}

Map<String, Object?> jsonToMap(Object? json) {
  if (json == null) return {};
  return copyJson(json) as Map<String, Object?>;
}
