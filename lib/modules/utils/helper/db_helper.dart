import 'dart:developer';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:database_project/modules/utils/models/helperModel.dart';

class DBhelper {
  DBhelper._();

  static final DBhelper dBhelper = DBhelper._();
  static Database? database;

  String city = "city";
  String id = "id";
  String name = "name";
  String tableName = "Database";

  initDB() async {
    String path = await join(await getDatabasesPath(), 'database.db');

    database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        String query =
            '''CREATE TABLE `$tableName` (`$id` INTEGER SAUTOINCREMENT, `$name` TEXT, `$city` TEXT);''';

        await db.execute(query);
      },
    );
  }

  Future<int?> insertData({required Data data}) async {
    await initDB();

    String query = "INSERT INTO `$tableName` (`$name`, `$city`) VALUES(?,?);";

    log("-----------------------------");
    log("-----------------------------");
    log("${data.name} ID: ${data.id}");
    log("-----------------------------");
    log("-----------------------------");

    List argus = [data.name, data.city];

    int? res = await database?.rawInsert(query, argus);

    return res;
  }
}
