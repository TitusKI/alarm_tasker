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
      // to change the color of the leading or the drawer icon to white
      appBar: AppBar(
        title: Text(
          'Tasks',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      drawer: drawer(context),

      body: Container(
          // color: Colors.white,
          ),
    );
  }
}
