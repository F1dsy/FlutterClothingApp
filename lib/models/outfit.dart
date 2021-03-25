import 'dart:io';

import 'item.dart';
import 'categories.dart';

class Outfit {
  final int? id;
  OutfitCategory category;
  List<Item?> items;
  File? featureImage;

  Outfit({
    required this.id,
    required this.category,
    required this.items,
    this.featureImage,
  });
}
