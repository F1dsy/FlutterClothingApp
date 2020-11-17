import 'package:FlutterClothingApp/models/categories.dart';
import 'package:flutter/foundation.dart';
import '../models/categories.dart';

import '../helpers/db_helper.dart' as DBHelper;

enum CategoryType {
  Outfit,
  Item
}

abstract class BaseCategoryProvider {

List _categories = [];



 Function _makeFetchAndSetCategories(DBHelper.Tables table, List<String> fields, CategoryType categoryType) {
 return () async {
    final result = await DBHelper.query(DBHelper.Tables.OutfitCategories);
    switch (categoryType) {
      case CategoryType.Item:
        _categories =
        result.map((e) => ItemCategory(e['id'], e['title'])).toList();
      break;
      case CategoryType.Outfit:
       _categories =
        result.map((e) => OutfitCategory(e['id'], e['title'])).toList();
        break;
    }
    // notifyListeners();
 };
}
  Future<void> insertCategory(String title) async {
    final id = await DBHelper.insert(
        DBHelper.Tables.OutfitCategories, {'title': title});
    _categories.add(OutfitCategory(id, title));
    notifyListeners();

}

abstract class BaseProvider {
  void fetchAndSetItems();
  Future<void> insertItem();
}
