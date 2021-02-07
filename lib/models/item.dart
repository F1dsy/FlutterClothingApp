import 'dart:io';
import 'package:flutter/material.dart';
import 'categories.dart';

class Item {
  final int id;
  ItemCategory category;
  File image;

  Item({
    @required this.id,
    @required this.category,
    this.image,
  });
}
