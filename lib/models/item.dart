import 'dart:io';
import 'categories.dart';

class Item {
  final int? id;
  ItemCategory? category;
  File? image;

  Item({
    required this.id,
    required this.category,
    this.image,
  });
}
