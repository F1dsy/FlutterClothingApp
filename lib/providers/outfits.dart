import 'package:FlutterClothingApp/models/categories.dart';
import 'package:flutter/material.dart';

import '../helpers/db_helper.dart' as DBHelper;
import '../models/outfit.dart';
import '../models/item.dart';

class Outfits with ChangeNotifier {
  set update(List<Item> value) {
    if (value.isEmpty) return;
    fetchAndSetOutfits(value);
  }

  List<Outfit> _outfits = [];

  List<Outfit> get outfits {
    return [..._outfits];
  }

  List<Outfit> outfitsOfCategory(OutfitCategory category) {
    return _outfits.where((outfit) => outfit.category == category).toList();
  }

  Future<void> fetchAndSetOutfits(List<Item> items) async {
    final outfits = await DBHelper.query(DBHelper.Tables.Outfits);
    final itemsOfOutfit = await DBHelper.query(DBHelper.Tables.OutfitItems);
    _outfits = outfits.map((outfit) {
      List<Item> itemList = [];
      for (var item in itemsOfOutfit) {
        if (item['outfit_id'] == outfit['id']) {
          itemList.add(items.firstWhere(
            (e) => e.id == item['item_id'],
            orElse: () {
              return null;
            },
          ));
        }
      }

      return Outfit(
        id: outfit['id'],
        category: outfit['category'],
        items: itemList,
      );
    }).toList();

    notifyListeners();
  }

  Future<void> insertOutfit(OutfitCategory category, List<Item> items) async {
    final id = await DBHelper.insert(
        DBHelper.Tables.Outfits, {'category': category.title});
    for (var item in items) {
      DBHelper.insert(
          DBHelper.Tables.OutfitItems, {'outfit_id': id, 'item_id': item.id});
    }
    _outfits.insert(0, Outfit(id: id, category: category, items: items));
    notifyListeners();
  }

  void deleteOutfit(Outfit outfit) async {
    DBHelper.delete(DBHelper.Tables.Outfits, outfit.id);

    _outfits.remove(outfit);
    notifyListeners();
  }

  void moveToCategory(List<Outfit> outfits, OutfitCategory newCategory) {
    for (var outfit in outfits) {
      outfit.category = newCategory;
    }
    notifyListeners();
  }
}
