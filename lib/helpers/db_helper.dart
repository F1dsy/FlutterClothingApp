import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Future<Database> _database() async {
    final dbPath = await getDatabasesPath();
    final db = await openDatabase(join(dbPath, 'app.db'),
        onCreate: (db, version) async {
      db.execute(
          'CREATE TABLE ItemCategories(id INTEGER PRIMARY KEY, title TEXT);');
      db.execute(
          'CREATE TABLE Items(id INTEGER PRIMARY KEY, category TEXT, imageURL TEXT);');
    }, version: 1);
    return db;
  }

  static Future<int> insert(String table, Map<String, dynamic> values) async {
    final Database db = await DBHelper._database();
    int result = await db.insert(table, values);
    return result;
  }

  static Future<List<Map<String, dynamic>>> query(String table) async {
    final Database db = await DBHelper._database();
    return db.query(table);
  }
}
