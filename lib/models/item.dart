import 'package:flutter/cupertino.dart';

class Item {
  String title;
  final int id;
  String category;
  String imageURL;

  Item({
    @required this.title,
    @required this.id,
    @required this.category,
    this.imageURL,
  });
}
