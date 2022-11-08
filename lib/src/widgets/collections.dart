import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_sqlite/firestore_sqlite.dart';
import 'package:flutter/material.dart';

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
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
