import 'package:sqflite/sqflite.dart';

import '../models/task.dart';

class DBHelper {
  static Database? _db;
  static const int _version = 1;
  static const String _taskTable = 'task';

  static initDB() async {
    if (_db != null)
      return;
    else {
      try {
        var databasesPath = await getDatabasesPath() + 'task.db';
        _db = await openDatabase(databasesPath, version: _version,
            onCreate: (Database db, int _version) async {
          print('create db ');
          await db.execute('''
              CREATE TABLE $_taskTable(
                 id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, note TEXT, 
                 date STRING, startTime STRING, endTime STRING, 
                 remind INTEGER, repeat STRING, 
                 color INTEGER, isCompleted INTEGER )
              
              ''');
          print('create db 15156156 ');
        });
      } catch (e) {
        print(e);
      }
    }
  }

  static Future<int> insert(Task? task) async {
    print('insert in DB');
    return await _db!.insert(_taskTable, task!.tojson());
  }

  static Future<int> delete(Task task) async {
    return await _db!
        .delete(_taskTable, where: 'id == ?', whereArgs: [task.id]);
  }

  static Future<List<Map<String, dynamic>>> query() async {
    print('query in DB');
    return await _db!.query(_taskTable);
  }

  static Future<int> update(int id) async {
    return await _db!.rawUpdate('''
  
  UPDATE task
  SET isCompleted == ?
  WHERE id == ?
  
  ''', [1, id]);
  }
}
