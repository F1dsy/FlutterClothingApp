import 'package:flutter/material.dart';
import '../models/outfit.dart';
import '../helpers/db_helper.dart' as DBHelper;

class Outfits with ChangeNotifier {
  List<Outfit> _outfits = [];

  List<Outfit> get outfits {
    return [..._outfits];
  }

  List<String> stringToList(String categories) {
    return categories.split(';');
  }

  String listToString(List<String> list) {
    return list.join(';');
  }

  List<Outfit> itemsOfCategory(String category) {
    return _outfits
        .where(
          (element) => element.categories
              .contains((element) => element.categories == category),
        )
        .toList();
  }

  Future<void> fetchAndSetItems() async {
    final result = await DBHelper.query(DBHelper.Tables.Items);
    _outfits = result
        .map(
          (e) => Outfit(
            id: e['id'],
            categories: stringToList(e['category']),
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> insertItem(List<String> categories, String imageURL) async {
    final id = await DBHelper.insert(
        DBHelper.Tables.Items, {'categories': listToString(categories)});
    _outfits.insert(0, Outfit(id: id, categories: categories));
  }
}
