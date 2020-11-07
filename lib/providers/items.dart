import 'package:flutter/foundation.dart';

import '../helpers/db_helper.dart';
import '../models/item.dart';

class Items with ChangeNotifier {
  List<Item> _items = [];

  List<Item> get items {
    return [..._items];
  }

  Future<void> fetchAndSetItems() async {
    final result = await DBHelper.query('Items');
    _items = result
        .map((e) => Item(
              title: e['title'],
              id: e['id'],
              category: e['category'],
            ))
        .toList();
    notifyListeners();
  }

  void insertItem(String title) {
    DBHelper.insert('Items', {'title': title});
  }
}
