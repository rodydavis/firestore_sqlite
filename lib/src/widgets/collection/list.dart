import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_sqlite/firestore_sqlite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                  icon: const Icon(Icons.copy),
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
                      leading: const Icon(Icons.edit),
                      onTap: () => modifyCollection(
                        context,
                        collection: collection,
                        collections: collections,
                      ),
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
      await value.save();
    }
  }
}
