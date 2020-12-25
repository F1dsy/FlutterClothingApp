import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';

import '../../providers/item_categories.dart';
import '../../providers/items.dart';

class WashBasketScreen extends StatelessWidget {
  static const routeName = '/wash-basket';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).washBasket),
      ),
      body: Container(
        child: FutureBuilder(
          future: Future.wait(
            {
              Provider.of<ItemCategories>(context).fetchAndSetCategories(),
              Provider.of<Items>(context).fetchAndSetItems(),
            },
          ),
          builder: (context, snapshot) => Consumer2<ItemCategories, Items>(
            builder: (context, categories, items, child) => ListView.builder(
              itemBuilder: (context, i) => Column(
                children: [
                  ListTile(
                    leading: Text(categories.categories[i].title),
                  ),
                  Container(
                    height: 150,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, j) => Card(
                        child: Image.file(
                          File(items
                              .itemsOfCategory(
                                  categories.categories[i].title)[j]
                              .imageURL),
                        ),
                      ),
                      itemCount: items
                          .itemsOfCategory(categories.categories[i].title)
                          .length,
                    ),
                  )
                ],
              ),
              itemCount: categories.categories.length,
            ),
          ),
        ),
      ),
    );
  }
}
