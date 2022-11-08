import 'package:flutter/material.dart';

class AdminConsole extends StatelessWidget {
  const AdminConsole({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: Validate no collections have same name
    // TODO: Validate keys are unique across fields
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Console'),
      ),
    );
  }
}
