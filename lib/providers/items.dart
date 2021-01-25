import 'dart:io';

import 'package:flutter/foundation.dart';

import '../helpers/db_helper.dart' as DBHelper;
import '../models/item.dart';
import '../models/categories.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Items with ChangeNotifier {
  set update(List<ItemCategory> value) {
    if (value.isEmpty) return;
    fetchAndSetItems(value);
  }

  int _washThreshold;
  List<Item> _items = [];

  List<Item> get items {
    return [..._items];
  }

  List<Item> itemsOfCategory(ItemCategory category) {
    return _items.where((element) => element.category == category).toList();
  }

  List<Item> itemsOnlyOfId(List<int> ids) {
    List<Item> filtered = [];
    ids.forEach((id) {
      filtered.addAll(_items.where((item) => item.id == id));
    });
    return filtered;
  }

  Future<void> fetchAndSetItems(List<ItemCategory> categories) async {
    List<Map<String, dynamic>> result =
        await DBHelper.query(DBHelper.Tables.Items);

    SharedPreferences preferences = await SharedPreferences.getInstance();
    _washThreshold = preferences.getInt('washThreshold');
    _items = result.map((e) {
      Item item = Item(
        id: e['id'],
        category: categories
            .firstWhere((category) => category.id == e['category_id']),
        image: File(e['imageURL']),
        isInWash: e['isInWash'] == 1,
        timeOfWash:
            e['timeOfWash'] != null ? DateTime.tryParse(e['timeOfWash']) : null,
      );

      _timeSinceInWash(item);
      return item;
    }).toList();
    notifyListeners();
  }

  Future<void> insertItem(ItemCategory category, File image) async {
    final id = await DBHelper.insert(DBHelper.Tables.Items,
        {'category_id': category.id, 'imageURL': image.path, 'isInWash': 0});
    _items.insert(0, Item(id: id, category: category, image: image));
    notifyListeners();
  }

  void deleteItem(Item item) {
    DBHelper.delete(DBHelper.Tables.Items, item.id);
    DBHelper.delete(
      DBHelper.Tables.OutfitItems,
      item.id,
      whereString: 'item_id = ?',
    );
    _items.remove(item);
    item.image.deleteSync();
    notifyListeners();
  }

  void addToWashBasket(Item item) {
    DBHelper.update(DBHelper.Tables.Items, {
      'id': item.id,
      'isInWash': 1,
      'timeOfWash': DateTime.now().toIso8601String(),
    });
  }

  void removeFromWashBasket(Item item) {
    DBHelper.update(DBHelper.Tables.Items, {
      'id': item.id,
      'isInWash': 0,
      'timeOfWash': null,
    });
  }

  Item _timeSinceInWash(Item item) {
    DateTime time = item.timeOfWash;

    if (time == null) return item;
    Duration dif = DateTime.now().difference(time);

    if (dif.inDays > _washThreshold) {
      item.isInWash = false;
      item.timeOfWash = null;
    }
    return item;
  }

  void moveToCategory(List<Item> items, ItemCategory newCategory) {
    for (var item in items) {
      item.category = newCategory;
    }
    notifyListeners();
  }
}
