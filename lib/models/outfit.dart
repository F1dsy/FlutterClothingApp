import 'package:flutter/foundation.dart';
import 'item.dart';

class Outfit {
  final int id;
  String category;
  List<Item> items;
  // String imageURL;

  Outfit({
    @required this.id,
    @required this.category,
    @required this.items,
    // this.imageURL,
  });
}
