import 'package:FlutterClothingApp/screens/outfits_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/drawer.dart';
import '../widgets/popup_add_category.dart';
import '../providers/outfit_categories.dart';
import '../providers/outfits.dart';

class OutfitsCategoriesScreen extends StatelessWidget {
  static const routeName = '/';
  void _addNewCategory(BuildContext context, String name) {
    if (name.isEmpty) {
      return;
    }
    Provider.of<OutfitCategories>(context, listen: false).insertCategory(name);
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      appBar: AppBar(
        title: Text('Outfits'),
        actions: [PopUpAddCategory(_addNewCategory)],
      ),
      body: FutureBuilder(
        future: Provider.of<OutfitCategories>(context, listen: false)
            .fetchAndSetCategories(),
        builder: (context, snapshot) => Consumer<OutfitCategories>(
          builder: (context, data, child) => ListView.builder(
            itemBuilder: (context, i) => ChangeNotifierProvider(
              create: (context) => Outfits(),
              child: OutfitCategoryItem(data.categories[i].title),
            ),
            itemCount: data.categories.length,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}

class OutfitCategoryItem extends StatelessWidget {
  final String title;

  OutfitCategoryItem(this.title);
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .pushNamed(OutfitsScreen.routeName, arguments: title);
        },
        child: ListTile(
          title: Text(title),
        ),
      ),
    );
  }
}
