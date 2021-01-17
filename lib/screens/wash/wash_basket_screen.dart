import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';

import '../../providers/item_categories.dart';
import '../../providers/items.dart';
import '../../models/item.dart';
import '../../widgets/custom_app_bar.dart';

class WashBasketScreen extends StatelessWidget {
  static const routeName = '/wash-basket';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(AppLocalizations.of(context).washBasket),
      ),
      body: Container(
        child: FutureBuilder(
          future: Future.wait(
            {
              Provider.of<ItemCategories>(context, listen: false)
                  .fetchAndSetCategories(),
              Provider.of<Items>(context, listen: false).fetchAndSetItems(),
            },
          ),
          builder: (context, snapshot) => Consumer2<ItemCategories, Items>(
            builder: (context, categories, items, child) => ListView.builder(
              itemBuilder: (context, i) {
                List<Item> inWashItems = items
                    .itemsOfCategory(categories.categories[i].title)
                    .where((item) => item.isInWash == true)
                    .toList();
                return Column(
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
                            inWashItems[j].image,
                          ),
                        ),
                        itemCount: inWashItems.length,
                      ),
                    )
                  ],
                );
              },
              itemCount: categories.categories.length,
            ),
          ),
        ),
      ),
    );
  }
}
