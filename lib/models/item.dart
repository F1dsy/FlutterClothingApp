import 'dart:io';
import 'categories.dart';
import 'item_data.dart';

class Item {
  final int id;
  ItemCategory category;
  File image;
  Temperature? temperature;
  Formality? formality;

  Item({
    required this.id,
    required this.category,
    required this.image,
    this.temperature,
    this.formality,
  });
}
