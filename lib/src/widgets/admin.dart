import 'package:flutter/material.dart';

import '../client.dart';
import 'collection/list.dart';

class AdminConsole extends StatefulWidget {
  const AdminConsole({super.key, required this.client});
  final FirestoreClient client;

  @override
  State<AdminConsole> createState() => _AdminConsoleState();
}

class _AdminConsoleState extends State<AdminConsole> {
  int index = 0;

  void setIndex(int value) {
    if (mounted) {
      setState(() {
        index = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Validate no collections have same name
    return Row(
      children: [
        SizedBox(
          width: 250,
          child: Scaffold(
            appBar: AppBar(
              title: const Text('Admin Console'),
            ),
            body: ListView(
              children: [
                ListTile(
                  title: const Text('Collections'),
                  leading: const Icon(Icons.collections),
                  selected: index == 0,
                  onTap: () => setIndex(0),
                ),
              ],
            ),
          ),
        ),
        const VerticalDivider(width: 0),
        Expanded(
          child: IndexedStack(
            index: index,
            children: [
              CollectionsEditor(
                automaticallyImplyLeading: false,
                client: widget.client,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
