import 'dart:io';

import 'package:flutter/services.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';

import '../config/localization.dart' show getLocale;

enum Tables {
  ItemCategories,
  Items,
  ItemData,
  OutfitCategories,
  Outfits,
  OutfitItems,
  Events
}

String returnTable(Tables e) {
  return e.toString().split('.').last;
}

late Database _db;

Future<void> databaseInit() async {
  final String dbDirectory = await getDatabasesPath();
  final String dbPath = join(dbDirectory, 'app.db');
  final bool exists = await databaseExists(dbPath);

  if (!exists) {
    Locale locale = getLocale();
    ByteData byteData;
    try {
      byteData = await rootBundle
          .load('assets/database/app_' + locale.languageCode + '.db');
    } catch (error) {
      byteData = await rootBundle.load('assets/database/app_en.db');
    }

    List<int> bytes = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);

    await File(dbPath).writeAsBytes(bytes, flush: true);
  }

  _db = await openDatabase(dbPath);
}

Future<int> insert(Tables e, Map<String, dynamic> values) async {
  final String table = returnTable(e);
  // final Database db = _db;
  int result = await _db.insert(table, values);
  return result;
}

Future<List<Map<String, dynamic>>> query(
  Tables e, {
  String? whereString,
  List? whereArgs,
}) {
  final String table = returnTable(e);
  // final Database db = _db;

  return _db.query(table, where: whereString, whereArgs: whereArgs);
}

void delete(Tables e, int? id, {String whereString = 'id = ?'}) {
  final String table = returnTable(e);
  // final Database db = _db;
  _db.delete(table, where: whereString, whereArgs: [id]);
}

void update(Tables e, Map<String, dynamic> values) {
  final String table = returnTable(e);
  // final Database db = _db;
  _db.update(table, values, where: 'id = ?', whereArgs: [values['id']]);
}
