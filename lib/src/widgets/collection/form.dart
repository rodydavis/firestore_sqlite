import 'dart:convert';

import 'package:firestore_sqlite/firestore_sqlite.dart';

import '../form.dart';
import 'package:flutter/material.dart';

class CollectionForm extends StatefulWidget {
  const CollectionForm({
    super.key,
    required this.collection,
    this.id,
    this.doc,
  });

  final Collection collection;
  final String? id;
  final Doc? doc;

  @override
  State<CollectionForm> createState() => _CollectionFormState();
}

class _CollectionFormState extends State<CollectionForm> {
  late final doc = widget.doc ?? Doc.modify(widget.collection, widget.id);
  final formKey = GlobalKey<FormState>();
  bool edited = false;
  final data = <String, Object?>{};

  @override
  void initState() {
    super.initState();
    doc.startBatch();
    if (widget.id != null && widget.doc == null) {
      doc.reload().then((value) {
        formKey.currentState?.reset();
        data.addAll(doc.toJson());
      });
    } else {
      data.addAll(doc.toJson());
    }
  }

  Future<void> save(BuildContext context) async {
    final nav = Navigator.of(context);
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      final now = DateTime.now().toIso8601String();
      data['created'] ??= now;
      data['updated'] = now;
      final valid = widget.collection.validate(data);
      if (valid.valid) {
        doc.endBatch();
        doc.setJson(data);
        await doc.save();
        nav.pop();
      } else {
        nav.push(
          MaterialPageRoute(
            builder: (context) => Scaffold(
              appBar: AppBar(
                title: const Text('Errors'),
              ),
              body: ListView(
                children: [
                  for (final error in valid.errors)
                    ListTile(
                      title: Text(error),
                    ),
                ],
              ),
            ),
            fullscreenDialog: true,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      onChanged: () => setState(() => edited = true),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onWillPop: () async {
        if (edited) await save(context);
        return true;
      },
      child: Scaffold(
        appBar: buildAppBar(context),
        body: ListView.builder(
          itemCount: widget.collection.restFields.length,
          itemBuilder: (context, index) {
            final field = widget.collection.restFields[index];
            return buildField(context, field);
          },
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(widget.id == null
          ? 'New ${widget.collection.name}'
          : 'Edit ${widget.collection.name} Document'),
      actions: [
        IconButton(
          tooltip: 'Save',
          icon: const Icon(Icons.save),
          onPressed: !edited
              ? null
              : () async {
                  final nav = Navigator.of(context);
                  await save(context);
                  if (mounted) {
                    setState(() {
                      edited = false;
                    });
                  }
                  nav.pop();
                },
        ),
      ],
    );
  }

  Widget buildField(BuildContext context, Field field) {
    final key = field.name;
    final label = field.name;
    final value = doc[key];
    final defaults = CollectionX.defaultFields;
    if (defaults.map((e) => e.name).contains(field.name)) {
      return const SizedBox.shrink();
    }
    return field.type.maybeWhen(
      string: (maxLength) => textField(
        label: label,
        value: value as String?,
        onChanged: (value) => data[key] = value,
        required: field.required ?? false,
      ),
      document: (collection, _) => textField(
        label: '$label ($collection)',
        value: value as String?,
        onChanged: (value) => data[key] = value,
        required: field.required ?? false,
      ),
      int: () => intField(
        label: label,
        value: value as int?,
        onChanged: (value) => data[key] = value,
        required: field.required ?? false,
      ),
      num: () => numberField(
        label: label,
        value: value as num?,
        onChanged: (value) => data[key] = value,
        required: field.required ?? false,
      ),
      double: () => doubleField(
        label: label,
        value: value as double?,
        onChanged: (value) => data[key] = value,
        required: field.required ?? false,
      ),
      bool: () => boolField(
        label: label,
        value: value as bool?,
        onChanged: (value) => data[key] = value,
        required: field.required ?? false,
      ),
      // map: map,
      // array: array,
      // blob: blob,
      option: (options) => dropdownField(
        label: label,
        items: options,
        value: value as String?,
        onChanged: (value) => data[key] = value,
        required: field.required ?? false,
      ),
      date: () => dateField(
        label: label,
        value: value as DateTime?,
        onChanged: (value) => data[key] = value,
        required: field.required ?? false,
      ),
      // dynamic: dynamic,
      orElse: () => Container(),
    );
  }
}
