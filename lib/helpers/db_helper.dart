import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

enum Tables { ItemCategories, Items, OutfitCategories, Outfits, OutfitItems }

String returnTable(Tables e) {
  return e.toString().split('.').last;
}

Future<Database> _database() async {
  final dbPath = await getDatabasesPath();
  final db =
      await openDatabase(join(dbPath, 'app.db'), onCreate: (db, version) async {
    db.execute(
        'CREATE TABLE ItemCategories(id INTEGER PRIMARY KEY, title TEXT);');
    db.execute(
        'CREATE TABLE Items(id INTEGER PRIMARY KEY, category TEXT, imageURL TEXT, isInWash INTEGER, timeOfWash INTEGER);');
    db.execute(
        'CREATE TABLE OutfitCategories(id INTEGER PRIMARY KEY, title TEXT);');
    db.execute(
        'CREATE TABLE Outfits(id INTEGER PRIMARY KEY, categories TEXT);');
    db.execute(
        'CREATE TABLE OutfitItems(outfit_id INTEGER, item_id INTEGER, FOREIGN KEY(outfit_id) REFERENCES Outfits(id) ON DELETE CASCADE, FOREIGN KEY(item_id) REFERENCES Items(id) ON DELETE CASCADE);');
  }, version: 1);
  return db;
}

Future<int> insert(Tables e, Map<String, dynamic> values) async {
  final String table = returnTable(e);
  final Database db = await _database();
  int result = await db.insert(table, values);
  return result;
}

Future<List<Map<String, dynamic>>> query(Tables e) async {
  final String table = returnTable(e);
  final Database db = await _database();
  return db.query(table);
}
