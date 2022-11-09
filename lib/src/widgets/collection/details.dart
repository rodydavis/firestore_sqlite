import 'package:firestore_sqlite/firestore_sqlite.dart';
import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(collection.name),
        actions: [
          IconButton(
            tooltip: 'Edit Collection',
            icon: const Icon(Icons.edit),
            onPressed: () async {
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
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Doc>>(
        stream: collection.watchDocuments(),
        builder: (context, snapshot) {
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
                          DataCell(Text('${doc[field.name] ?? ''}'.toString())),
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
  }
}
