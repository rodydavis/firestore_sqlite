import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firestore_sqlite/firestore_sqlite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'firebase.dart';
import 'generated/client.dart';

final client = Client();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase(emulators: kDebugMode);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const Example(),
        if (kDebugMode) '/admin': (_) => const AdminConsole(),
      },
    );
  }
}

class Example extends StatefulWidget {
  const Example({super.key});

  @override
  State<Example> createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  final collection = client.artist;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    collection.checkForUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore SQLite'),
        actions: [
          if (kDebugMode)
            IconButton(
              tooltip: 'Admin Console',
              icon: const Icon(Icons.admin_panel_settings),
              onPressed: () => Navigator.of(context).pushNamed('/admin'),
            ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
            ),
            onChanged: (value) => setState(() {}),
          ),
          Expanded(
            child: controller.text.trim().isEmpty
                ? StreamBuilder(
                    stream: collection.watch(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final items = snapshot.data ?? [];
                      return buildDocs(items);
                    },
                  )
                : FutureBuilder(
                    future: collection.search(controller.text),
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      final items = snapshot.data ?? [];
                      return buildDocs(items);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget buildDocs(List<Doc> items) {
    if (items.isEmpty) {
      return const Center(child: Text('No items found'));
    }
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        final artist = Artist(id: item.id);
        artist.setJson(item.data());
        return ListTile(
          title: Text(artist.name ?? 'N/A'),
          subtitle: Text(item.id),
        );
      },
    );
  }
}
