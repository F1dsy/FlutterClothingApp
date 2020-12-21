import 'package:flutter/material.dart';
import '../models/outfit.dart';
import '../models/item.dart';
import 'items.dart';
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

  List<Outfit> outfitsOfCategory(String category) {
    return _outfits
        .where((outfit) => outfit.categories.contains(category))
        .toList();
  }

  Future<void> fetchAndSetOutfits() async {
    final outfits = await DBHelper.query(DBHelper.Tables.Outfits);
    final itemsOfOutfit = await DBHelper.query(DBHelper.Tables.OutfitItems);
    Items items = Items();
    await items.fetchAndSetItems();
    List<Item> itemList = [];
    _outfits = outfits.map((outfit) {
      for (var item in itemsOfOutfit) {
        if (item['outfit_id'] == outfit['id']) {
          itemList.add(items.items
              .firstWhere((element) => element.id == item['item_id']));
        }
      }
      return Outfit(
        id: outfit['id'],
        categories: stringToList(outfit['categories']),
        items: itemList,
      );
    }).toList();
    notifyListeners();
  }

  Future<void> insertOutfit(List<String> categories, List<Item> items) async {
    final id = await DBHelper.insert(
        DBHelper.Tables.Outfits, {'categories': listToString(categories)});
    for (var item in items) {
      DBHelper.insert(
          DBHelper.Tables.OutfitItems, {'outfit_id': id, 'item_id': item.id});
    }

    _outfits.insert(0, Outfit(id: id, categories: categories, items: items));
  }
}
