import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../screens/item_screen.dart';
import '../providers/item_categories.dart';
import '../providers/items.dart';

//The whole Screen with all Item Categories
class ItemsCategoriesScreen extends StatefulWidget {
  @override
  _ItemsCategoriesScreenState createState() => _ItemsCategoriesScreenState();
}

class _ItemsCategoriesScreenState extends State<ItemsCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<ItemCategories>(context, listen: false)
          .fetchAndSetCategories(),
      builder: (context, snapshot) => Consumer<ItemCategories>(
        builder: (context, data, child) => ListView.builder(
          itemBuilder: (context, i) => ChangeNotifierProvider(
            create: (context) => Items(),
            child: ItemCategoryItem(data.categories[i].title),
          ),
          itemCount: data.categories.length,
        ),
      ),
    );
  }
}

// Single Category Item
class ItemCategoryItem extends StatelessWidget {
  final String title;

  ItemCategoryItem(this.title);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {},
        child: ListTile(
          title: Text(title),
        ),
      ),
    );
  }
}
