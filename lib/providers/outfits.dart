import 'dart:io';

import '../models/categories.dart';
import 'package:flutter/material.dart';

import '../helpers/db_helper.dart' as DBHelper;
import '../models/outfit.dart';
import '../models/item.dart';

class Outfits with ChangeNotifier {
  List<Outfit> _outfits = [];

  List<Outfit> get outfits {
    return [..._outfits];
  }

  List<Outfit> outfitsOfCategory(OutfitCategory? category) {
    return _outfits.where((outfit) => outfit.category == category).toList();
  }

  Future<void> fetchAndSetOutfits(
      List<Item> items, List<OutfitCategory> categories) async {
    if (items.isEmpty || categories.isEmpty) return;
    final outfits = await DBHelper.query(DBHelper.Tables.Outfits);
    final itemsOfOutfit = await DBHelper.query(DBHelper.Tables.OutfitItems);
    _outfits = outfits.map((outfit) {
      List<Item> itemList = [];
      for (var item in itemsOfOutfit) {
        if (item['outfit_id'] == outfit['id']) {
          itemList.add(items.firstWhere(
            (e) => e.id == item['item_id'],
          ));
        }
      }

      return Outfit(
        id: outfit['id'],
        category: categories
            .firstWhere((category) => category.id == outfit['category_id']),
        items: itemList,
        featureImage: outfit['feature_imageURL'] == null
            ? null
            : File(outfit['feature_imageURL']),
      );
    }).toList();

    notifyListeners();
  }

  Future<void> insertOutfit(
      OutfitCategory category, List<Item> items, File? featureImage) async {
    final id = await DBHelper.insert(DBHelper.Tables.Outfits, {
      'category_id': category.id,
      'feature_imageURL': featureImage == null ? null : featureImage.path,
    });
    for (var item in items) {
      DBHelper.insert(
          DBHelper.Tables.OutfitItems, {'outfit_id': id, 'item_id': item.id});
    }
    _outfits.add(Outfit(
      id: id,
      category: category,
      items: items,
      featureImage: featureImage,
    ));
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
