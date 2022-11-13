import 'dart:convert';

import 'package:firestore_sqlite/firestore_sqlite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/json.dart';
import '../form.dart';

class EditCollection extends StatefulWidget {
  const EditCollection({
    super.key,
    this.collection,
    required this.collections,
  });

  final Collection? collection;
  final List<Collection> collections;

  @override
  State<EditCollection> createState() => _EditCollectionState();
}

class _EditCollectionState extends State<EditCollection> {
  late Collection? collection = widget.collection;
  late final data = copyJson(collection ?? {}) as Map<String, Object?>;
  final formKey = GlobalKey<FormState>();
  final controller = ScrollController();
  bool edited = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      removeDefaults();
      delayedValidate();
    });
  }

  void removeDefaults() {
    final fields = CollectionX.defaultFields;
    final dataFields = data['fields'] as List<dynamic>?;
    for (final field in fields) {
      dataFields?.removeWhere((e) => e['name'] == field.name);
    }
    if (mounted) setState(() {});
  }

  void delayedValidate() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));
    formKey.currentState!.validate();
  }

  void save(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      // Add default fields
      final fields = CollectionX.defaultFields;
      final dataFields = data['fields'] as List<dynamic>? ?? [];
      for (final field in fields) {
        if (dataFields.any((e) => e['name'] == field.name) != true) {
          dataFields.add(copyJson(field));
        }
      }
      for (final f in dataFields) {
        // Remove name from previous if exists
        final prev = f['previous'] as List? ?? [];
        prev.removeWhere((e) => e == f['name']);
        f['previous'] = prev;
      }
      data['fields'] = dataFields;
      data['updated'] ??= DateTime.now().toIso8601String();
      data['created'] ??= DateTime.now().toIso8601String();
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
              tooltip: 'Read json from Clipboard to generate fields',
              icon: const Icon(Icons.paste),
              onPressed: () async {
                final messenger = ScaffoldMessenger.of(context);
                final jsonString = await Clipboard.getData('text/plain');
                if (jsonString?.text == null) {
                  messenger.showSnackBar(
                    const SnackBar(
                      content: Text('No json found in Clipboard'),
                    ),
                  );
                  return;
                }
                try {
                  final jsonData = jsonDecode(jsonString!.text!);
                  Map? target;
                  if (jsonData is List) {
                    target = jsonData.first;
                  } else if (jsonData is Map) {
                    target = jsonData;
                  }
                  if (target != null) {
                    // Try to convert json into field type
                    final fields = <Field>[];
                    for (final entry in target.entries) {
                      final name = entry.key;
                      final value = entry.value;
                      if (value is String) {
                        fields.add(
                          Field(
                            name: name,
                            type: const FieldType.string(),
                          ),
                        );
                      } else if (value is num) {
                        fields.add(
                          Field(
                            name: name,
                            type: const FieldType.num(),
                          ),
                        );
                      } else if (value is int) {
                        fields.add(
                          Field(
                            name: name,
                            type: const FieldType.int(),
                          ),
                        );
                      } else if (value is double) {
                        fields.add(
                          Field(
                            name: name,
                            type: const FieldType.double(),
                          ),
                        );
                      } else if (value is bool) {
                        fields.add(
                          Field(
                            name: name,
                            type: const FieldType.bool(),
                          ),
                        );
                      }
                    }
                    if (mounted) {
                      setState(() {
                        data['fields'] = copyJson(fields);
                        removeDefaults();
                      });
                    }
                    formKey.currentState!.reset();
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('Fields generated from json'),
                      ),
                    );
                  }
                } catch (e) {
                  messenger.showSnackBar(
                    SnackBar(
                      content: Text('Invalid json found in Clipboard: $e'),
                    ),
                  );
                }
              },
            ),
            IconButton(
              tooltip: 'Save Collection',
              onPressed: !edited ? null : () => save(context),
              icon: const Icon(Icons.save),
            ),
          ],
        ),
        body: Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: () {
            if (mounted) {
              setState(() {
                edited = true;
              });
            }
          },
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              children: [
                textField(
                  label: 'Name',
                  required: true,
                  value: collection?.name,
                  validator: (value) {
                    // Only allow lowercase letters and underscores and dash
                    final regex = RegExp(r'^[a-z0-9_-]+$');
                    if (regex.hasMatch(value)) return null;
                    return 'Only lowercase letters and underscores/hyphens allowed';
                  },
                  onChanged: (value) {
                    data['name'] = value?.trim();
                  },
                ),
                textField(
                  label: 'Description',
                  value: collection?.description,
                  onChanged: (value) {
                    data['description'] = value;
                  },
                ),
                boolField(
                  label: 'Bundle',
                  value: collection?.bundle,
                  onChanged: (value) {
                    data['bundle'] = value;
                  },
                ),
                Builder(
                  builder: (context) {
                    final fields =
                        copyJson(data['fields'] ?? []) as List<dynamic>;
                    return Column(
                      children: [
                        ListTile(
                          title: const Text('Fields'),
                          leading: IconButton(
                            onPressed: () async {
                              if (mounted) {
                                setState(() {
                                  final newField = const Field(
                                    name: '',
                                    type: FieldType.string(),
                                  ).toJson();
                                  data['fields'] = [...fields, newField];
                                  edited = true;
                                });
                              }
                              await Future<void>.delayed(
                                  const Duration(milliseconds: 100));
                              formKey.currentState!.validate();
                              controller.jumpTo(
                                controller.position.maxScrollExtent,
                              );
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ),
                        for (var i = 0; i < fields.length; i++)
                          Card(
                            child: Builder(
                              builder: (context) {
                                try {
                                  final f = fields[i];
                                  final field = Field.fromJson(f);
                                  final raw = data['fields'] as List;
                                  if (CollectionX.defaultFields
                                      .map((e) => e.name)
                                      .contains(field.name)) {
                                    return ListTile(
                                      title: Text(field.name),
                                      subtitle: const Text('Default field'),
                                    );
                                  }
                                  final prev =
                                      (raw[i]['previous'] as List? ?? [])
                                          .map((e) => e.toString())
                                          .toList();
                                  return Column(
                                    children: [
                                      textField(
                                        label: 'Name',
                                        required: true,
                                        value: field.name,
                                        validator: (value) {
                                          // Only allow letters and underscores (case insensitive)
                                          final regex =
                                              RegExp(r'^[a-zA-Z_-]+$');
                                          if (regex.hasMatch(value)) {
                                            final allFields = <String>{};
                                            final dataFields =
                                                data['fields'] as List<dynamic>;
                                            for (final f in dataFields) {
                                              allFields.add(f['name']);
                                              allFields.addAll(
                                                  ((f['previous'] ?? [])
                                                          as List<dynamic>)
                                                      .map((e) => e.toString())
                                                      .toList());
                                            }
                                            allFields.addAll(CollectionX
                                                .defaultFields
                                                .map((e) => e.name));
                                            if (allFields.contains(value) &&
                                                value != field.name) {
                                              return 'Field name already exists';
                                            }
                                            return null;
                                          }
                                          return 'Only lowercase letters and underscores/hyphens allowed';
                                        },
                                        onChanged: (value) {
                                          if (prev.isEmpty &&
                                              widget.collection == null) {
                                            raw[i]['name'] = value?.trim();
                                          } else {
                                            raw[i]['previous'] = {
                                              ...prev,
                                              field.name
                                            }.toSet().toList();
                                            raw[i]['name'] = value?.trim();
                                          }
                                        },
                                      ),
                                      if (prev.isNotEmpty)
                                        ListTile(
                                          title: const Text('Previous Names'),
                                          subtitle: Text(
                                              field.previous?.join(', ') ?? ''),
                                        ),
                                      dropdownField(
                                        label: 'Type',
                                        value: field.type.typeInfo,
                                        required: true,
                                        items: fieldTypes,
                                        onChanged: (value) {
                                          raw[i]['type'] =
                                              parseFieldType(value!).toJson();
                                          delayedValidate();
                                        },
                                      ),
                                      field.type.maybeWhen(
                                        string: (maxLength) => intField(
                                          label: 'Max Length',
                                          value: maxLength,
                                          onChanged: (val) {
                                            raw[i]['type'] =
                                                (field.type as StringField)
                                                    .copyWith(maxLength: val)
                                                    .toJson();
                                          },
                                        ),
                                        blob: (bucket) => textField(
                                          label: 'Bucket',
                                          value: bucket,
                                          required: true,
                                          onChanged: (val) {
                                            raw[i]['type'] =
                                                (field.type as BlobField)
                                                    .copyWith(bucket: val!)
                                                    .toJson();
                                          },
                                        ),
                                        document: (doc, triggerDelete) =>
                                            Column(
                                          children: [
                                            dropdownField(
                                              label: 'Collection',
                                              value: doc,
                                              required: true,
                                              items: widget.collections
                                                  .map((e) => e.name)
                                                  .toList(),
                                              onChanged: (value) {
                                                raw[i]['type'] = (field.type
                                                        as DocumentField)
                                                    .copyWith(
                                                        collection: value!)
                                                    .toJson();
                                              },
                                            ),
                                            boolField(
                                              label: 'Trigger Delete',
                                              value: triggerDelete,
                                              onChanged: (val) {
                                                raw[i]['type'] = (field.type
                                                        as DocumentField)
                                                    .copyWith(
                                                        triggerDelete: val)
                                                    .toJson();
                                              },
                                            ),
                                          ],
                                        ),
                                        option: (options) => textField(
                                          label: 'Values',
                                          value: options.join(','),
                                          required: true,
                                          onChanged: (val) {
                                            final items = val!.split(',');
                                            raw[i]['type'] =
                                                (field.type as OptionField)
                                                    .copyWith(values: items)
                                                    .toJson();
                                          },
                                        ),
                                        orElse: () => Container(),
                                      ),
                                      textField(
                                        label: 'Description',
                                        value: field.description,
                                        onChanged: (value) {
                                          raw[i]['description'] = value;
                                        },
                                      ),
                                      boolField(
                                        label: 'Required',
                                        value: field.required,
                                        onChanged: (value) {
                                          raw[i]['required'] = value;
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            if (mounted) {
                                              setState(() {
                                                raw.removeAt(i);
                                                edited = true;
                                              });
                                            }
                                          },
                                          icon: const Icon(Icons.delete),
                                          label: const Text('Delete'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } catch (e) {
                                  debugPrint(e.toString());
                                  return Container();
                                }
                              },
                            ),
                          ),
                      ],
                    );
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
