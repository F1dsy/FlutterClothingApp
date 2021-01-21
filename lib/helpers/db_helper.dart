import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

enum Tables {
  ItemCategories,
  Items,
  OutfitCategories,
  Outfits,
  OutfitItems,
  Events
}

String returnTable(Tables e) {
  return e.toString().split('.').last;
}

Future<Database> _database() async {
  final dbPath = await getDatabasesPath();
  final db =
      await openDatabase(join(dbPath, 'app.db'), onCreate: (db, version) {
    Future.wait([
      db.execute(
          'CREATE TABLE ItemCategories(id INTEGER PRIMARY KEY, title TEXT);'),
      db.execute(
          'CREATE TABLE Items(id INTEGER PRIMARY KEY, category TEXT, imageURL TEXT, isInWash INTEGER, timeOfWash INTEGER);'),
      db.execute(
          'CREATE TABLE OutfitCategories(id INTEGER PRIMARY KEY, title TEXT);'),
      db.execute(
          'CREATE TABLE Outfits(id INTEGER PRIMARY KEY, category TEXT);'),
      db.execute(
          'CREATE TABLE OutfitItems(outfit_id INTEGER, item_id INTEGER, FOREIGN KEY(outfit_id) REFERENCES Outfits(id) ON DELETE CASCADE, FOREIGN KEY(item_id) REFERENCES Items(id) ON DELETE CASCADE);'),
      db.execute(
          'CREATE TABLE Events(event_id INTEGER PRIMARY KEY, date TEXT, outfit_id INTEGER);'),
    ]);
  }, version: 1);
  return db;
}

Future<int> insert(Tables e, Map<String, dynamic> values) async {
  final String table = returnTable(e);
  final Database db = await _database();
  int result = await db.insert(table, values);
  return result;
}

Future<List<Map<String, dynamic>>> query(
  Tables e, {
  String whereString,
  List whereArgs,
}) async {
  final String table = returnTable(e);
  final Database db = await _database();
  return db.query(table, where: whereString, whereArgs: whereArgs);
}

Future<void> delete(Tables e, int id, {String whereString = 'id = ?'}) async {
  final String table = returnTable(e);
  final Database db = await _database();
  db.delete(table, where: whereString, whereArgs: [id]);
}

Future<void> update(Tables e, Map<String, dynamic> values) async {
  final String table = returnTable(e);
  final Database db = await _database();
  db.update(table, values, where: 'id = ?', whereArgs: [values['id']]);
}
