import 'package:FlutterClothingApp/main.dart';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/custom_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Locale language;

  @override
  void didChangeDependencies() {
    SharedPreferences.getInstance().then((preferences) {
      String string = preferences.getString('language');
      setState(() {
        language = Locale(string);
      });
    });
    super.didChangeDependencies();
  }

  selectDialog(BuildContext context) {
    void _select(Locale value) async {
      language = value;
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('language', value.languageCode);
      MyApp.setLocale(context, value);
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
      appBar: CustomAppBar(
        title: Text(AppLocalizations.of(context).settings),
      ),
      body: Column(
        children: [
          RaisedButton(
              onPressed: () {
                return selectDialog(context);
              },
              child: Text('Language'))
        ],
      ),
    );
  }
}
