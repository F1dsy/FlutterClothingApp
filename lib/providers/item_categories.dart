import 'package:flutter/foundation.dart';

import '../models/categories.dart';
import '../helpers/db_helper.dart' as DBHelper;

class ItemCategories with ChangeNotifier {
  List<ItemCategory> _categories = [];

  List<ItemCategory> get categories {
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
}
