import 'package:flutter/material.dart';

Widget textField({
  required String label,
  required String? value,
  required ValueChanged<String?> onChanged,
  String? Function(String value)? validator,
  bool required = false,
}) {
  return ListTile(
    title: TextFormField(
      onSaved: onChanged,
      validator: (val) {
        if (required) {
          if (val == null || val == '') {
            return '$label required';
          }
        }
        if (val != null && validator != null) {
          return validator(val);
        }
        return null;
      },
      initialValue: value,
      decoration: InputDecoration(
        label: Text(label),
      ),
    ),
  );
}

Widget dropdownField({
  required String label,
  required String? value,
  required List<String> items,
  required ValueChanged<String?> onChanged,
  String? Function(String value)? validator,
  bool required = false,
}) {
  return ListTile(
    title: DropdownButtonFormField<String>(
      onSaved: onChanged,
      validator: (val) {
        if (required) {
          if (val == null || val == '') {
            return '$label required';
          }
        }
        if (val != null && validator != null) {
          return validator(val);
        }
        return null;
      },
      value: items.contains(value) ? value : null,
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(item),
              ))
          .toList(),
      onChanged: (val) => onChanged(val),
      decoration: InputDecoration(
        label: Text(label),
      ),
    ),
  );
}

Widget numberField({
  required String label,
  required num? value,
  required ValueChanged<num?> onChanged,
  String? Function(num? value)? validator,
  bool required = false,
}) {
  return ListTile(
    title: TextFormField(
      onSaved: (val) => onChanged(val == null ? null : num.tryParse(val)),
      validator: (val) {
        if (required) {
          if (val == null || val == '') {
            return '$label required';
          }
        }
        if (val != null && val.isNotEmpty && num.tryParse(val) == null) {
          return '$label must be a valid number';
        }
        if (val != null && validator != null) {
          return validator(num.tryParse(val));
        }
        return null;
      },
      initialValue: value?.toString(),
      decoration: InputDecoration(
        label: Text(label),
      ),
    ),
  );
}

Widget intField({
  required String label,
  required int? value,
  required ValueChanged<int?> onChanged,
  String? Function(int? value)? validator,
  bool required = false,
}) {
  return numberField(
    label: label,
    value: value,
    onChanged: (val) => onChanged(val?.toInt()),
    validator: (val) {
      if (validator != null) {
        return validator(val?.toInt());
      }
      return null;
    },
    required: required,
  );
}

Widget doubleField({
  required String label,
  required double? value,
  required ValueChanged<double?> onChanged,
  String? Function(double? value)? validator,
  bool required = false,
}) {
  return numberField(
    label: label,
    value: value,
    onChanged: (val) => onChanged(val?.toDouble()),
    validator: (val) {
      if (validator != null) {
        return validator(val?.toDouble());
      }
      return null;
    },
    required: required,
  );
}

Widget boolField({
  required String label,
  required bool? value,
  required ValueChanged<bool?> onChanged,
  String? Function(bool value)? validator,
  bool required = false,
}) {
  return ListTile(
    title: Text(label),
    trailing: Switch(
      value: value == true,
      onChanged: onChanged,
    ),
  );
}

Widget dateField({
  required String label,
  required DateTime? value,
  required ValueChanged<DateTime?> onChanged,
  String? Function(DateTime value)? validator,
  bool required = false,
}) {
  return ListTile(
    title: TextFormField(
      onSaved: (val) => onChanged(val == null ? null : DateTime.parse(val)),
      validator: (val) {
        if (required) {
          if (val == null || val == '') {
            return '$label required';
          }
        }
        if (val != null && val.isNotEmpty && DateTime.tryParse(val) == null) {
          return '$label must be a valid date';
        }
        if (val != null && validator != null) {
          return validator(DateTime.parse(val));
        }
        return null;
      },
      initialValue: value?.toIso8601String(),
      decoration: InputDecoration(
        label: Text(label),
      ),
    ),
  );
}
