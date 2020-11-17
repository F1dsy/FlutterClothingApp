import 'package:flutter/foundation.dart';
import 'item.dart';

class Outfit {
  final int id;
  List<String> categories;
  List<Item> items;
  // String imageURL;

  Outfit({
    @required this.id,
    @required this.categories,
    this.items,
    // this.imageURL,
  });
}
