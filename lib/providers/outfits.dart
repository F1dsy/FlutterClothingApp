import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

import '../models/outfit.dart';
import '../models/item.dart';
// import 'items.dart';
import '../helpers/db_helper.dart' as DBHelper;

class Outfits with ChangeNotifier {
  set update(List value) {
    fetchAndSetOutfits(value);
  }

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

  Future<void> fetchAndSetOutfits(List<Item> items) async {
    // print('outfits');
    final outfits = await DBHelper.query(DBHelper.Tables.Outfits);
    // print('Outfits' + outfits.toString());
    final itemsOfOutfit = await DBHelper.query(DBHelper.Tables.OutfitItems);
    // print('ItemsOfOutfit' + itemsOfOutfit.toString());

    // print('items' + items.toString());
    _outfits = outfits.map((outfit) {
      List<Item> itemList = [];
      for (var item in itemsOfOutfit) {
        if (item['outfit_id'] == outfit['id']) {
          // itemList.add(items.firstWhere((e) => e.id == item['item_id']));
          itemList.addAll(items.where((e) => e.id == item['item_id']));
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
