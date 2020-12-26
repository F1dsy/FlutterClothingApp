import 'package:flutter/foundation.dart';

import '../helpers/db_helper.dart' as DBHelper;
import '../models/item.dart';

class Items with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items {
    return [..._items];
  }

  List<Item> itemsOfCategory(String category) {
    return _items.where((element) => element.category == category).toList();
  }

  List<Item> itemsOnlyOfId(List<int> ids) {
    List<Item> filtered = [];
    ids.forEach((id) {
      filtered.addAll(_items.where((item) => item.id == id));
    });
    return filtered;
  }

  Future<void> fetchAndSetItems() async {
    final result = await DBHelper.query(DBHelper.Tables.Items);
    _items = result
        .map((e) => Item(
              id: e['id'],
              category: e['category'],
              imageURL: e['imageURL'],
              isInWash: e['isInWash'] == 1,
            ))
        .toList();
    notifyListeners();
  }

  Future<void> insertItem(String category, String imageURL) async {
    final id = await DBHelper.insert(DBHelper.Tables.Items,
        {'category': category, 'imageURL': imageURL, 'isInWash': 0});
    _items.insert(0, Item(id: id, category: category, imageURL: imageURL));
  }

  void deleteItem(Item item) {
    DBHelper.delete(DBHelper.Tables.Items, item.id);
    _items.remove(item);
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
}
