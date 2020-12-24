import 'package:flutter/cupertino.dart';

class Item {
  final int id;
  String category;
  String imageURL;
  bool isInWash = false;
  DateTime timeOfWash;

  Item({
    @required this.id,
    @required this.category,
    this.imageURL,
  });
}
