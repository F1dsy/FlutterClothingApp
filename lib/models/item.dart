import 'dart:io';
import 'package:flutter/material.dart';
import 'categories.dart';

class Item {
  final int id;
  ItemCategory category;
  File image;
  bool isInWash = false;
  DateTime timeOfWash;

  Item(
      {@required this.id,
      @required this.category,
      this.image,
      this.isInWash,
      this.timeOfWash});
}
