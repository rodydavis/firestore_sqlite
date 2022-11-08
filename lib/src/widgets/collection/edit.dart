import 'package:firestore_sqlite/firestore_sqlite.dart';
import 'package:flutter/material.dart';

import '../form.dart';

class EditCollection extends StatefulWidget {
  const EditCollection({super.key, this.collection});

  final Collection? collection;

  @override
  State<EditCollection> createState() => _EditCollectionState();
}

class _EditCollectionState extends State<EditCollection> {
  late Collection? collection = widget.collection;
  late final data = collection?.toJson() ?? <String, Object?>{};
  final formKey = GlobalKey<FormState>();
  bool edited = false;

  void save(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      collection = Collection.fromJson(data);
      Navigator.of(context).pop(collection);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (edited) {
          // Discard changes?
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('${collection == null ? 'Add' : 'Edit'} Collection'),
          actions: [
            IconButton(
              tooltip: 'Save Collection',
              onPressed: !edited ? null : () => save(context),
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        body: Form(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: () {
            if (mounted) {
              setState(() {
                edited = true;
              });
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                textField(
                  label: 'Name',
                  required: true,
                  value: collection?.name,
                  onChanged: (value) {
                    data['name'] = value?.trim();
                  },
                  validator: (value) {
                    final regex = RegExp(r'^[a-z_]+$');
                    if (regex.hasMatch(value)) {
                      return null;
                    }
                    return 'Only lowercase letters and underscores allowed';
                  },
                ),
                textField(
                  label: 'Description',
                  value: collection?.description,
                  onChanged: (value) {
                    data['description'] = value;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
