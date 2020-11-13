import 'package:flutter/cupertino.dart';

class Item {
  final int id;
  String category;
  String imageURL;

  Item({
    @required this.id,
    @required this.category,
    this.imageURL,
  });
}
