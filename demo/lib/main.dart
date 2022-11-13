import 'dart:convert';

import 'package:firestore_sqlite/firestore_sqlite.dart';
import 'package:firestore_sqlite/src/widgets/collection/edit.dart';
import 'package:firestore_sqlite/src/widgets/collection/list.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Schema Editor',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const SchemaBuilder(),
    );
  }
}

class SchemaBuilder extends StatefulWidget {
  const SchemaBuilder({super.key});

  @override
  State<SchemaBuilder> createState() => _SchemaBuilderState();
}

class _SchemaBuilderState extends State<SchemaBuilder> {
  final List<Collection> collections = [];
  late SharedPreferences preferences;
  static const schemasKey = 'schemas';

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      preferences = value;
      final jsonString = preferences.getString(schemasKey);
      if (jsonString != null && jsonString.isNotEmpty) {
        final list = jsonDecode(jsonString) as List;
        collections.clear();
        for (final map in list) {
          try {
            collections.add(Collection.fromJson(map));
          } catch (e) {
            debugPrint('error parsing collection: ${jsonEncode(map)} $e');
          }
        }
        if (mounted) setState(() {});
      }
    });
  }

  void save() async {
    await preferences.setString(schemasKey, jsonEncode(collections));
  }

  void edit(BuildContext context, [int? index]) {
    Navigator.of(context)
        .push<Collection?>(
      MaterialPageRoute(
        builder: (context) => EditCollection(
          collections: collections,
          collection: index == null ? null : collections[index],
        ),
        fullscreenDialog: true,
      ),
    )
        .then((value) {
      if (value != null) {
        setState(() {
          if (index == null) {
            collections.add(value);
          } else {
            collections[index] = value;
          }
          save();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schema Builder'),
        actions: [
          CopySchemas(collections: collections),
          ReadSchemas(onRead: (collections) async {
            if (mounted) {
              setState(() {
                this.collections.clear();
                this.collections.addAll(collections);
                save();
              });
            }
          }),
          IconButton(
            tooltip: 'Clear',
            icon: const Icon(Icons.clear),
            onPressed: collections.isEmpty
                ? null
                : () {
                    if (mounted) {
                      setState(() {
                        collections.clear();
                        save();
                      });
                    }
                  },
          ),
        ],
      ),
      body: collections.isEmpty
          ? const Center(child: Text('No Collections'))
          : ListView.builder(
              itemCount: collections.length,
              itemBuilder: (context, index) {
                final collection = collections[index];
                return ListTile(
                  title: Text(collection.name),
                  subtitle: collection.description == null ||
                          collection.description!.isEmpty
                      ? null
                      : Text(collection.description!),
                  onTap: () => edit(context, index),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => edit(context),
        tooltip: 'Add Collection',
        child: const Icon(Icons.add),
      ),
    );
  }
}
