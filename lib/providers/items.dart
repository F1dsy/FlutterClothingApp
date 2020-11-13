import 'package:flutter/foundation.dart';

import '../helpers/db_helper.dart';
import '../models/item.dart';

class Items with ChangeNotifier {
  List<Item> _items = [Item(id: null, category: null)];

  List<Item> get items {
    return [..._items];
  }

  List<Item> itemsOfCategory(String category) {
    return _items.where((element) => element.category == category).toList();
  }

  Future<void> fetchAndSetItems() async {
    final result = await DBHelper.query('Items');
    _items = result
        .map(
          (e) => Item(
            id: e['id'],
            category: e['category'],
            imageURL: e['imageURL'],
          ),
        )
        .toList();
    notifyListeners();
  }

  Future<void> insertItem(String category, String imageURL) async {
    final id = await DBHelper.insert(
        'Items', {'category': category, 'imageURL': imageURL});
    _items.insert(0, Item(id: id, category: category, imageURL: imageURL));
  }
}
