import 'dart:io';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DatabaseUser {
  final String databaseName = 'student.db';
  final dbVersion = 1;
  static final String table = 'table_user';
  static final String Id = 'id';
  static final String Name = 'name';
  static final String Age = 'age';
  //static final String Email= 'email';

  static Database? _database;
  static DatabaseUser? databaseUser;

  DatabaseUser._createInstance();
  static final DatabaseUser instance = DatabaseUser._createInstance();

  factory DatabaseUser({id, name, age}) {
    if (databaseUser == null) {
      databaseUser = DatabaseUser.instance;
    }
    return databaseUser!;
  }

  factory DatabaseUser.fromMap(Map<String, dynamic> json) => DatabaseUser(
        id: json["id"],
        name: json["name"],
        age: json["age"],
      );

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = p.join(databasesPath, databaseName);

      var database = await openDatabase(
        path,
        version: dbVersion,
        onCreate: (db, version) {
          db.execute('''
          create table $table ( 
          $Id INTEGER PRIMARY KEY, 
          $Name text not null, 
          $Age INTEGER not null   
           )
        ''');
        },
      );
      // print('------database database : $database');
      return database;
    } catch (e) {
      print("HelloDatabase Error : ${e.toString()}");
      return null!;
    }
  }

  // Insert data in database
  Future<int> insert(Map<String, dynamic> row) async {
    var db = await instance.database;
    return await db.insert(table, row);
  }

  // Query command
  Future<List<Map<String, dynamic>>> queryAll() async {
    var db = await instance.database;
    return await db.query(table);
  }

  // query specific
  Future<List<Map<String, dynamic>>> queryspecific(int age) async {
    var db = await instance.database;
    var result = await db.query(table, where: 'age>?', whereArgs: [age]);
    return result;
  }

  Future<int> UpdateRecord(int id) async {
    var db = await instance.database;
    var res = await db.update(table, {"name": "Ali", "age": 2},
        where: 'Id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> DeleteRecord(int id) async {
    var db = await instance.database;
    var res = await db.delete(table, where: '$Id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> getCount() async {
    try {
      var db = await instance.database;
      var result = await db.query(table);
      return result.length;
    } catch (e) {
      print("HelloDatabase Error : ${e.toString()}");
      return 0;
    }
  }

  Future<List<Map<String, dynamic>>> GetAllRecord() async {
    try {
      List<Map<String, dynamic>> student_list = [];

      var db = await instance.database;
      var result = await db.query(table);
      if (result.length > 0) {
        for (int i = 0; i < result.length; i++) {
          print("${result[i]}");
          //DatabaseUser modal = DatabaseUser.fromMap(result[i]);
          student_list.add(result[i]);
        }
        print("SifatLog Values length ${student_list.length}");
        return student_list;
      } else {
        return null!;
      }
    } catch (e) {
      print("HelloDatabase Error : ${e.toString()}");
      return null!;
    }
  }
}
