import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../widgets/custom_app_bar.dart';
import '../../models/outfit.dart';
import '../../models/event.dart';
import '../../models/categories.dart';
import '../../providers/outfit_categories.dart';
import '../../providers/events.dart';
import '../../providers/outfits.dart';
import '../outfits/outfit_widget.dart';
import '../../l10n/app_localizations.dart';

enum _SelectStep {
  Category,
  Outfit,
  Confirm,
}

class AddEventScreen extends StatefulWidget {
  static const routeName = '/addEvent';

  @override
  _AddEventScreenState createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  _SelectStep _selectStep = _SelectStep.Category;

  Outfit _selectedOutfit;
  DateTime _selectedDay;

  void _selectCategory(OutfitCategory category) {
    setState(() {
      _selectStep = _SelectStep.Outfit;
    });
  }

  void _selectOutfit(Outfit outfit) {
    setState(() {
      _selectStep = _SelectStep.Confirm;
      _selectedOutfit = outfit;
    });
  }

  void _selectDate() async {
    _selectedDay = await showDatePicker(
          context: context,
          initialDate: _selectedDay,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
        ) ??
        _selectedDay;
  }

  void _addEvent() {
    Provider.of<Events>(context, listen: false).addEvent(Event(
      id: null,
      date: _selectedDay,
      outfit: _selectedOutfit,
    ));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    _selectedDay = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(AppLocalizations.of(context).addEvent),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _addEvent,
          )
        ],
      ),
      body: (() {
        switch (_selectStep) {
          case _SelectStep.Category:
            return _SelectCategory(_selectCategory);
            break;
          case _SelectStep.Outfit:
            return _SelectOutfit(_selectOutfit);
            break;
          case _SelectStep.Confirm:
            return _Confirm(
              _selectedOutfit,
              _selectedDay,
              _selectDate,
            );
            break;
          default:
        }
      }()),
    );
  }
}

class _SelectCategory extends StatelessWidget {
  final Function select;
  _SelectCategory(this.select);
  @override
  Widget build(BuildContext context) {
    return Consumer<OutfitCategories>(
      builder: (context, data, child) => ListView.builder(
        itemCount: data.categories.length,
        itemBuilder: (context, i) => Card(
          child: ListTile(
            onTap: () => select(data.categories[i]),
            title: Text(data.categories[i].title),
          ),
        ),
      ),
    );
  }
}

class _SelectOutfit extends StatelessWidget {
  final Function select;
  _SelectOutfit(this.select);
  @override
  Widget build(BuildContext context) {
    return Consumer<Outfits>(
      builder: (context, data, child) => StaggeredGridView.countBuilder(
        crossAxisCount: 3,
        itemCount: data.outfits.length,
        itemBuilder: (context, i) => OutfitWidget(data.outfits[i], select),
        staggeredTileBuilder: (_) => StaggeredTile.fit(1),
      ),
    );
  }
}

class _Confirm extends StatelessWidget {
  final Outfit outfit;
  final DateTime date;
  final Function selectDate;

  _Confirm(
    this.outfit,
    this.date,
    this.selectDate,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          child: Center(
            child: OutfitWidget(
              outfit,
              (_) {},
            ),
          ),
        ),
        Container(
          child: RaisedButton(
            onPressed: selectDate,
            child: Text(DateFormat.yMd().format(date)),
          ),
        ),
      ],
    );
  }
}
