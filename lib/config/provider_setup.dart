import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item_categories.dart';
import '../providers/items.dart';
import '../providers/outfits.dart';
import '../providers/outfit_categories.dart';
import '../providers/events.dart';

class ProviderSetup extends StatelessWidget {
  final Widget? child;

  ProviderSetup({
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ItemCategories()..fetchAndSetCategories(),
      ),
      ChangeNotifierProvider(
        create: (context) => OutfitCategories()..fetchAndSetCategories(),
      ),
      ChangeNotifierProxyProvider<ItemCategories, Items>(
        create: (context) => Items(),
        update: (context, categories, items) =>
            items!..update = categories.categories,
      ),
      ChangeNotifierProxyProvider2<Items, OutfitCategories, Outfits>(
        create: (context) => Outfits(),
        update: (context, items, categories, outfits) => outfits!
          ..fetchAndSetOutfits(items.itemAsList, categories.categories),
      ),
      ChangeNotifierProxyProvider<Outfits, Events>(
        create: (context) => Events(),
        update: (context, outfits, events) =>
            events!..fetchAndSetEvents(outfits.outfits),
      ),
    ], builder: (context, _) => child!);
  }
}
