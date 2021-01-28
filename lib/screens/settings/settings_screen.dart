import '../../main.dart';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../widgets/custom_app_bar.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  Future<Locale> _getLocale() async {
    return await SharedPreferences.getInstance()
        .then((preferences) => Locale(preferences.getString('language')));
  }

  _selectLanguageDialog(BuildContext context) {
    void _select(Locale value) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('language', value.languageCode);
      MyApp.setLocale(context, value);
      Navigator.of(context).pop();
    }

    _getLocale().then((language) => showDialog(
          context: context,
          child: StatefulBuilder(
            builder: (context, setState) => SimpleDialog(
              title: Text(AppLocalizations.of(context).selectLang),
              children: [
                RadioListTile(
                  value: Locale('en'),
                  groupValue: language,
                  onChanged: (value) => setState(() {
                    _select(value);
                  }),
                  title: Text('English'),
                ),
                RadioListTile(
                  value: Locale('de'),
                  groupValue: language,
                  onChanged: (value) => setState(() {
                    _select(value);
                  }),
                  title: Text('Deutsch'),
                ),
                RadioListTile(
                  value: Locale('da'),
                  groupValue: language,
                  onChanged: (value) => setState(() {
                    _select(value);
                  }),
                  title: Text('Dansk'),
                ),
              ],
            ),
          ),
        ));
  }

  Future<int> _getInWashTime() async {
    return await SharedPreferences.getInstance()
        .then((preferences) => preferences.getInt('washThreshold'));
  }

  void _selectInWashTimeDialog(BuildContext context) {
    void _setInWashTime(int value) async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setInt('washThreshold', value);
      Navigator.of(context).pop();
    }

    _getInWashTime().then((inWashTime) => showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            title: Text('Select Time in Wash'),
            children: List.generate(
              7,
              (i) => RadioListTile(
                title: Text('${i + 1} ${i == 0 ? 'day' : 'days'}'),
                value: i + 1,
                groupValue: inWashTime,
                onChanged: (value) => _setInWashTime(value),
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(AppLocalizations.of(context).settings),
      ),
      body: Column(
        children: [
          _SettingTile(
            title: 'Language',
            subtitle: 'Set the Language you want',
            buttonText: 'Select',
            onButtonTap: () => _selectLanguageDialog(context),
          ),
          _SettingTile(
            title: 'In Wash Time',
            subtitle: 'How long is your clothing in wash',
            buttonText: 'Select',
            onButtonTap: () => _selectInWashTimeDialog(context),
          ),
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final Function onButtonTap;
  _SettingTile({this.title, this.onButtonTap, this.subtitle, this.buttonText});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      title: Text(
        title,
        style: TextStyle(fontSize: 20),
      ),
      subtitle: Text(subtitle),
      trailing: RaisedButton(
        onPressed: onButtonTap,
        child: Text(buttonText),
      ),
    );
  }
}
