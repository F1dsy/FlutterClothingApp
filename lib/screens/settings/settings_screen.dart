import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../l10n/app_localizations.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  selectDialog(BuildContext context) {
    Locale language = Provider.of<LangProvider>(context, listen: false).locale;

    void _select(value) {
      language = value;
      Provider.of<LangProvider>(context, listen: false).changeLocale(value);
      Navigator.of(context).pop();
    }

    showDialog(
      context: context,
      child: StatefulBuilder(
        builder: (context, setState) => SimpleDialog(
          title: Text(AppLocalizations.of(context).selectLang),
          children: [
            RadioListTile(
              value: Locale('en'),
              groupValue: language,
              onChanged: (value) {
                setState(() {
                  _select(value);
                });
              },
              title: Text('English'),
            ),
            RadioListTile(
              value: Locale('de'),
              groupValue: language,
              onChanged: (value) {
                setState(() {
                  _select(value);
                });
              },
              title: Text('Deutsch'),
            ),
            RadioListTile(
              value: Locale('da'),
              groupValue: language,
              onChanged: (value) {
                setState(() {
                  _select(value);
                });
              },
              title: Text('Dansk'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).settings),
      ),
      body: Column(
        children: [
          RaisedButton(
              onPressed: () => selectDialog(context), child: Text('Language'))
        ],
      ),
    );
  }
}
