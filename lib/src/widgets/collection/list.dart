import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_sqlite/firestore_sqlite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../admin.dart';
import '../../utils/json.dart';
import 'details.dart';
import 'edit.dart';

class CollectionsEditor extends StatelessWidget {
  const CollectionsEditor({
    super.key,
    this.automaticallyImplyLeading = false,
  });
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    final db = FirebaseFirestore.instance;
    final schema = db.collection('schema');
    return StreamBuilder<List<Collection>>(
        stream: schema.snapshots().map((e) => e.docs
            .map((d) {
              final data = {...d.data(), "id": d.id};
              try {
                return Collection.fromJson(data);
              } catch (e) {
                debugPrint('error parsing collection: ${jsonEncode(data)} $e');
                return null;
              }
            })
            .whereType<Collection>()
            .toList()),
        builder: (context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Collections'),
              centerTitle: false,
              automaticallyImplyLeading: automaticallyImplyLeading,
              actions: [
                IconButton(
                  tooltip: 'Copy Schemas to Clipboard',
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
                  tooltip: 'Read Schemas from Clipboard',
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
                      final collections = data
                          .map((e) => Collection.fromJson(e))
                          .whereType<Collection>()
                          .toList();
                      await db.runTransaction((transaction) async {
                        for (final collection in collections) {
                          await collection.save(admin);
                        }
                      });
                      messenger.showSnackBar(
                        const SnackBar(
                          content: Text('Schemas saved'),
                        ),
                      );
                    } catch (e) {
                      messenger.showSnackBar(
                        SnackBar(
                          content: Text('Error parsing schemas: $e'),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
            body: Builder(
              builder: (context) {
                final collections = snapshot.data;
                if (collections == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (collections.isEmpty) {
                  return const Center(child: Text('No collections found'));
                }
                return ListView.builder(
                  itemCount: collections.length,
                  itemBuilder: (context, index) {
                    final collection = collections[index];
                    return ListTile(
                      title: Text(collection.name),
                      subtitle: collection.description != null &&
                              collection.description!.isNotEmpty
                          ? Text(collection.description!)
                          : null,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => CollectionDetails(
                          collection: collection,
                          collections: collections,
                        ),
                      )),
                    );
                  },
                );
              },
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => modifyCollection(
                context,
                collections: snapshot.data ?? [],
              ),
              child: const Icon(Icons.add),
            ),
          );
        });
  }

  Future<void> modifyCollection(
    BuildContext context, {
    Collection? collection,
    required List<Collection> collections,
  }) async {
    final navigator = Navigator.of(context);
    final value = await navigator.push<Collection?>(MaterialPageRoute(
      builder: (context) => EditCollection(
        collection: collection,
        collections: collections,
      ),
      fullscreenDialog: true,
    ));
    if (value != null) {
      await value.save(admin);
    }
  }
}
