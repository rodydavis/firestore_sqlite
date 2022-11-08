import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_sqlite/firestore_sqlite.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Collections'),
        centerTitle: false,
        automaticallyImplyLeading: automaticallyImplyLeading,
      ),
      body: StreamBuilder<List<Collection>>(
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
                subtitle: collection.description != null
                    ? Text(collection.description!)
                    : null,
                onTap: () => modifyCollection(context, collection),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => modifyCollection(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> modifyCollection(
    BuildContext context, [
    Collection? collection,
  ]) async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);
    final value = await navigator.push(MaterialPageRoute(
      builder: (context) => const EditCollection(),
      fullscreenDialog: true,
    ));
    if (value != null && value is Collection) {
      messenger.showSnackBar(const SnackBar(
        content: Text('Collection saved!'),
      ));
    }
  }
}
