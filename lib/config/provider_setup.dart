import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/item_categories.dart';
import '../providers/items.dart';
import '../providers/outfits.dart';
import '../providers/outfit_categories.dart';
import '../providers/events.dart';

class ProviderSetup extends StatelessWidget {
  final Widget child;

  ProviderSetup({
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => ItemCategories()..fetchAndSetCategories(),
        // lazy: false,
      ),
      ChangeNotifierProvider(
        create: (context) => OutfitCategories()..fetchAndSetCategories(),
        // lazy: false,
      ),
      ChangeNotifierProxyProvider<ItemCategories, Items>(
        create: (context) => Items(),
        update: (context, categories, items) =>
            items..update = categories.categories,
      ),
      ChangeNotifierProxyProvider<Items, Outfits>(
        create: (context) => Outfits(),
        update: (context, items, outfits) => outfits..update = items.itemAsList,
        // lazy: false,
      ),
      ChangeNotifierProxyProvider<Outfits, Events>(
        create: (context) => Events(),
        update: (context, outfits, events) => events..update = outfits.outfits,
        // lazy: false,
      ),
    ], builder: (context, _) => child);
  }
}
