import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(context),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('Tasks'),

        // leading
      ),
      body: Container(
        color: Colors.white,
      ),
    );
  }
}
