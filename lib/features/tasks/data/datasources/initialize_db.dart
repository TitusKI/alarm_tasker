import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

Future<Database> initializeDatabase() async {
  // Initialize FFI for desktop platforms
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Get the database path
  final databasePath = await getDatabasesPath();
  final path = join(databasePath, 'tasks.db');
  // await deleteDatabase(path);

  // Open the database
  return openDatabase(
    path,
    version: 2,
    onCreate: (db, version) async {
      // Create your tables here
      await db.execute('''
        CREATE TABLE tasks (
          id TEXT PRIMARY KEY,
          title TEXT NOT NULL
        )
      ''');
      await db.execute('''
        CREATE TABLE subtask_titles (
          id TEXT PRIMARY KEY,
          title TEXT NOT NULL,
          taskId TEXT NOT NULL,
          FOREIGN KEY (taskId) REFERENCES tasks (id) ON DELETE CASCADE
        )
      ''');
      await db.execute('''
        CREATE TABLE subtasks (
          id TEXT PRIMARY KEY,
          title TEXT NOT NULL,
          dueDate TEXT ,
          priority TEXT ,
          imagePath TEXT,
          description TEXT,
          isCompleted INTEGER NOT NULL,
          subTaskTitleId TEXT NOT NULL,
          FOREIGN KEY (subTaskTitleId) REFERENCES subtask_titles (id) ON DELETE CASCADE
        )
      ''');
    },
  );
}
