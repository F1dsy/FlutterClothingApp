import 'package:flutter/foundation.dart';

import '../models/categories.dart';
import '../helpers/db_helper.dart' as DBHelper;

class ItemCategories with ChangeNotifier {
  List<ItemCategory?> _categories = [];

  List<ItemCategory?> get categories {
    return [..._categories];
  }

  Future<void> fetchAndSetCategories() async {
    final result = await DBHelper.query(DBHelper.Tables.ItemCategories);
    _categories = result.map((e) => ItemCategory(e['id'], e['title'])).toList();
    notifyListeners();
  }

  Future<void> insertCategory(String title) async {
    final id =
        await DBHelper.insert(DBHelper.Tables.ItemCategories, {'title': title});
    _categories.add(ItemCategory(id, title));
    notifyListeners();
  }

  Future<bool> deleteCategory(ItemCategory category) async {
    List checkResult = await DBHelper.query(DBHelper.Tables.Items,
        whereString: 'category_id = ?', whereArgs: [category.id]);
    if (checkResult.isNotEmpty) return true;
    DBHelper.delete(DBHelper.Tables.ItemCategories, category.id);
    _categories.remove(category);
    notifyListeners();
    return false;
  }
}
