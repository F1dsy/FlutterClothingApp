import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/item_categories.dart';

class MoveItem extends StatelessWidget {
  static const routeName = '/move';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          // PopUpAddCategory(_addNewCategory),
        ],
      ),
      body: Consumer<ItemCategories>(
        builder: (context, data, child) => data.categories.isEmpty
            ? Center(
                child: Text('Add Category First'),
              )
            : ListView.builder(
                itemBuilder: (context, i) => Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pop(data.categories[i]);
                    },
                    title: Text(
                      data.categories[i]!.title!,
                    ),
                  ),
                ),
                itemCount: data.categories.length,
              ),
      ),
    );
  }
}
