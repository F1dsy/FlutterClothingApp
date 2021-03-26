import 'dart:io';

import '../models/item_data.dart';
import 'item.dart';
import 'categories.dart';

class Outfit {
  final int id;
  OutfitCategory category;
  List<Item> items;
  File? featureImage;
  Temperature? temperature;

  Outfit({
    required this.id,
    required this.category,
    required this.items,
    this.featureImage,
    this.temperature,
  });
}
