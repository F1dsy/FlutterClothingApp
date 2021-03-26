import 'dart:io';

import 'package:fabrics/models/item_data.dart';
import 'package:flutter/foundation.dart';

import '../helpers/db_helper.dart' as DBHelper;
import '../helpers/slider_labels.dart';

import '../models/item.dart';
// import '../models/item_data.dart';
import '../models/categories.dart';

class Items with ChangeNotifier {
  set update(List<ItemCategory> value) {
    if (value.isEmpty) return;
    fetchAndSetItems(value);
  }

  Map<ItemCategory, List<Item>> _items = {};

  Map<ItemCategory, List<Item>> get items {
    return {..._items};
  }

  List<Item> get itemAsList {
    return _items.values.expand((list) => list).toList();
  }

  Future<void> fetchAndSetItems(List<ItemCategory> categories) async {
    List<Map<String, dynamic>> items = await DBHelper.rawQuery(
        'SELECT * FROM Items LEFT JOIN ItemData ON Items.id = ItemData.item_id;');
    categories.forEach((category) => _items[category] = []);

    items.forEach((e) {
      ItemCategory category =
          categories.firstWhere((category) => category.id == e['category_id']);
      Item item = Item(
        id: e['id'],
        category: category,
        image: File(e['imageURL']),
        temperature: Temperature.values[e['temperature']],
      );
      _items[category]!.add(item);
    });
    notifyListeners();
  }

  Future<void> insertItem(
      ItemCategory category, File image, double temperature) async {
    final id = await DBHelper.insert(DBHelper.Tables.Items,
        {'category_id': category.id, 'imageURL': image.path});
    _items[category]!.add(Item(
        id: id,
        category: category,
        image: image,
        temperature: sliderValueToTemperatureEnum(temperature)));
    DBHelper.insert(DBHelper.Tables.ItemData, {
      'item_id': id,
      'temperature': temperature.toInt(),
    });
    notifyListeners();
  }

  void deleteItem(Item item) {
    DBHelper.delete(DBHelper.Tables.Items, item.id);
    DBHelper.delete(
      DBHelper.Tables.OutfitItems,
      item.id,
      whereString: 'item_id = ?',
    );
    _items[item.category]!.remove(item);
    item.image.deleteSync();
    notifyListeners();
  }

  void moveToCategory(List<Item> items, ItemCategory newCategory) {
    for (var item in items) {
      DBHelper.update(DBHelper.Tables.Items, {
        'id': item.id,
        'category_id': newCategory.id,
      });
      _items[item.category]!.remove(item);
      item.category = newCategory;
      _items[newCategory]!.add(item);
    }
    notifyListeners();
  }
}
