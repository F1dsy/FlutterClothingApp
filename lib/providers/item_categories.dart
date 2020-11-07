import 'package:flutter/foundation.dart';

import '../models/item_category.dart';
import '../helpers/db_helper.dart';

class ItemCategories with ChangeNotifier {
  List<ItemCategory> _categories = [];

  List<ItemCategory> get categories {
    return [..._categories];
  }

  Future<void> fetchAndSetCategories() async {
    final result = await DBHelper.query('ItemCategories');
    _categories = result.map((e) => ItemCategory(e['title'])).toList();
    notifyListeners();
  }

  void insertCategory(String title) {
    DBHelper.insert('ItemCategories', {'title': title});
  }
}
