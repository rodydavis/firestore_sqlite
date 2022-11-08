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
