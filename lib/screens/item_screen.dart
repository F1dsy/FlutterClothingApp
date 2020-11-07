import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/items.dart';

class ItemsScreen extends StatelessWidget {
  // final String title;

  // ItemsScreen(this.title);

  @override
  Widget build(BuildContext context) {
    // final String title = ModalRoute.of(context).settings.arguments;
    final items = Provider.of<Items>(context).items;
    return Scaffold(
      appBar: AppBar(
        title: Text('Items'),
      ),
      body: ListView.builder(
        itemBuilder: null,
        itemCount: items.length,
      ),
    );
  }
}
