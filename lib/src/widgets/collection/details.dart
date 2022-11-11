import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_sqlite/firestore_sqlite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../utils/json.dart';
import 'edit.dart';
import 'form.dart';

class CollectionDetails extends StatelessWidget {
  const CollectionDetails({
    super.key,
    required this.collection,
    required this.collections,
  });

  final Collection collection;
  final List<Collection> collections;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Doc>>(
      stream: collection.watchDocuments(),
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(collection.name),
            actions: [
              IconButton(
                tooltip: 'Edit Collection',
                icon: const Icon(Icons.edit),
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  final value =
                      await navigator.push<Collection?>(MaterialPageRoute(
                    builder: (context) => EditCollection(
                      collection: collection,
                      collections: collections,
                    ),
                    fullscreenDialog: true,
                  ));
                  if (value != null) {
                    await value.save();
                  }
                },
              ),
              IconButton(
                tooltip: 'Copy documents to Clipboard',
                icon: const Icon(Icons.file_copy),
                onPressed: snapshot.data == null
                    ? null
                    : () async {
                        final messenger = ScaffoldMessenger.of(context);
                        final jsonString = prettyPrintJson(snapshot.data!);
                        await Clipboard.setData(
                            ClipboardData(text: jsonString));
                        messenger.showSnackBar(
                          const SnackBar(
                            content: Text('Copied to Clipboard'),
                          ),
                        );
                      },
              ),
              IconButton(
                tooltip: 'Read documents from Clipboard',
                icon: const Icon(Icons.paste),
                onPressed: () async {
                  final messenger = ScaffoldMessenger.of(context);
                  final jsonString = await Clipboard.getData('text/plain');
                  if (jsonString?.text == null) {
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('No text found in Clipboard'),
                      ),
                    );
                    return;
                  }
                  try {
                    final data = jsonDecode(jsonString!.text!);
                    if (data is! List) {
                      throw const FormatException('Expected List');
                    }
                    final db = FirebaseFirestore.instance;
                    await db.runTransaction((transaction) async {
                      for (final item in data) {
                        transaction.set(
                          collection.reference.doc(item['id']),
                          item,
                        );
                      }
                    });
                    messenger.showSnackBar(
                      const SnackBar(
                        content: Text('Documents saved'),
                      ),
                    );
                  } catch (e) {
                    messenger.showSnackBar(
                      SnackBar(
                        content: Text('Error parsing documents: $e'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          body: Builder(
            builder: (context) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              }
              final docs = snapshot.data ?? [];
              if (docs.isEmpty) {
                return const Center(child: Text('No documents found'));
              }
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SingleChildScrollView(
                  child: DataTable(
                    columns: [
                      for (final field in collection.allFields)
                        DataColumn(label: Text(field.name)),
                      const DataColumn(label: Text('Delete')),
                    ],
                    rows: [
                      for (final doc in docs)
                        DataRow(
                          onLongPress: () => Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => CollectionForm(
                                collection: collection,
                                id: doc.id,
                                doc: doc,
                              ),
                            ),
                          ),
                          cells: [
                            for (final field in collection.allFields)
                              DataCell(
                                Text('${doc[field.name] ?? ''}'.toString()),
                              ),
                            DataCell(
                              IconButton(
                                tooltip: 'Delete',
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  final messenger =
                                      ScaffoldMessenger.of(context);
                                  final db = FirebaseFirestore.instance;
                                  await db.runTransaction((transaction) async {
                                    transaction.delete(doc.reference);
                                  });
                                  messenger.showSnackBar(
                                    const SnackBar(
                                      content: Text('Document deleted'),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => CollectionForm(
                  collection: collection,
                ),
              ),
            ),
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }
}
