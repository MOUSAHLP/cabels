import 'dart:io';

import 'package:cabels/data/model/cable_model.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  static const _databaseName = "myLocal.db";
  static const _databaseVersion = 1;
  static const table = "numbers";
  static const columnId = 'id';
  static const columnname = 'name';
  static const columnlocation = 'location';
  static const columnnumber = 'number';
  static const columnGateType = 'gateType';
  static const columnGateNumber = 'gateNumber';
  static const columnQaem = 'qaem';
  static const columnPort = 'port';
  static const columnmainCable = 'mainCable';
  static const columntank = 'tank';
  static const columncable = 'cable';
  static const columnbox = 'box';
  static const columnTerminal = 'terminal';
  static const columnhouse = 'house';

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    if (defaultTargetPlatform == TargetPlatform.android) {
      String path = join(await getDatabasesPath(), _databaseName);
      return await openDatabase(
        path,
        version: _databaseVersion,
        onCreate: _onCreate,
      );
    } else {
      var databaseFactory = databaseFactoryFfi;
      Directory appDocDir = await getApplicationDocumentsDirectory();
      Directory dir = Directory(appDocDir.path + "/Cabels");
      if (!await dir.exists()) {
        await dir.create();
      }
      String path = join(dir.path, _databaseName);
      return await databaseFactory.openDatabase(path,
          options: OpenDatabaseOptions(
            version: _databaseVersion,
            onCreate: _onCreate,
          ));
    }
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE $table (
    $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
    $columnname TEXT NOT NULL,
    $columnlocation TEXT NOT NULL,
    $columnnumber INTEGER NOT NULL,
    $columnGateType TEXT NOT NULL,
    $columnGateNumber INTEGER NOT NULL,
    $columnQaem INTEGER NOT NULL,
    $columnPort INTEGER NOT NULL,
    $columnmainCable INTEGER NOT NULL,
    $columntank INTEGER NOT NULL,
    $columncable INTEGER NOT NULL,
    $columnbox INTEGER NOT NULL,
    $columnTerminal INTEGER NOT NULL,
    $columnhouse TEXT NOT NULL
  )
  ''');
  }

  Future<int> insert(CableModel number) async {
    Database? db = await instance.database;
    print("insert number.toJson()");
    print(number.toJson());
    var res = await db!.insert(table, number.toJson());
    return res;
  }

  Future<int> update(CableModel number, String where) async {
    Database? db = await instance.database;
    var res = await db!.update(table, number.toJson(), where: where);
    var s = await queryAllRows();
    print("s==================");
    print(s);
    print("s==================");
    return res;
  }

  Future<List<Map<String, dynamic>>> queryAllRows({where = "1=1"}) async {
    Database? db = await instance.database;

    List<Map<String, Object?>> res =
        await db!.query(table, orderBy: "$columnId DESC", where: where);
    return res;
  }

  Future<int> delete(int id) async {
    Database? db = await instance.database;
    return await db!.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, Object?>>> clearTable() async {
    Database? db = await instance.database;
    return await db!.rawQuery("DELETE FROM $table");
  }

  Future<List<Map<String, Object?>>> filter({
    name = "",
    location = "",
    number = "",
    gateType = "",
    gateNumber = "",
    qaem = "",
    port = "",
    mainCable = "",
    tank = "",
    cable = "",
    box = "",
    terminal = "",
    house = "",
  }) async {
    Database? db = await instance.database;

    String sql = '''
            SELECT * FROM $table WHERE 
            $columnname LIKE '%$name%' AND
            $columnlocation LIKE '%$location%' AND
            $columnnumber LIKE '%$number%' AND
            $columnGateType LIKE '%$gateType%' AND
            $columnGateNumber LIKE '%$gateNumber%' AND
            $columnQaem LIKE '%$qaem%' AND
            $columnPort LIKE '%$port%' AND
            $columnmainCable LIKE '%$mainCable%' AND
            $columntank LIKE '%$tank%' AND
            $columncable LIKE '%$cable%' AND
            $columnbox LIKE '%$box%' AND
            $columnTerminal LIKE '%$terminal%' AND
            $columnhouse LIKE '%$house%'
            ''';
    sql += "ORDER BY id DESC";
    return await db!.rawQuery(sql);
  }
}
