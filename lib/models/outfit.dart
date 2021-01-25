import 'package:flutter/foundation.dart';
import 'item.dart';
import 'categories.dart';

class Outfit {
  final int id;
  OutfitCategory category;
  List<Item> items;
  // String imageURL;

  Outfit({
    @required this.id,
    @required this.category,
    @required this.items,
    // this.imageURL,
  });
}
