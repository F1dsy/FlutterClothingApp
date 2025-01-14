import 'package:flutter/material.dart';

import '../models/categories.dart';
import '../helpers/db_helper.dart' as DBHelper;

class OutfitCategories with ChangeNotifier {
  List<OutfitCategory> _categories = [];

  List<OutfitCategory> get categories {
    return [..._categories];
  }

  Future<void> fetchAndSetCategories() async {
    final result = await DBHelper.query(DBHelper.Tables.OutfitCategories);
    _categories =
        result.map((e) => OutfitCategory(e['id'], e['title'])).toList();
    notifyListeners();
  }

  Future<void> insertCategory(String title) async {
    final id = await DBHelper.insert(
        DBHelper.Tables.OutfitCategories, {'title': title});
    _categories.add(OutfitCategory(id, title));
    notifyListeners();
  }

  Future<bool> deleteCategory(OutfitCategory category) async {
    List checkResult = await DBHelper.query(DBHelper.Tables.Outfits,
        whereString: 'category = ?', whereArgs: [category.title]);
    if (checkResult.isNotEmpty) return true;
    DBHelper.delete(DBHelper.Tables.OutfitCategories, category.id);
    _categories.remove(category);
    notifyListeners();
    return false;
  }
}
