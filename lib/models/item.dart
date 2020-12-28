import 'dart:io';
import 'package:flutter/cupertino.dart';

class Item {
  final int id;
  String category;
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
