import '../../main.dart';
import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';
import '../../widgets/custom_app_bar.dart';
import '../../helpers/shared_preferences.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = '/settings';

  _selectLanguageDialog(BuildContext context) {
    void _select(Locale value) async {
      setSetting('language', value.languageCode);
      MyApp.setLocale(context, value);
      Navigator.of(context).pop();
    }

    getSetting<String>('language')
        .then((e) => Locale(e))
        .then((language) => showDialog(
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

  void _selectInWashTimeDialog(BuildContext context) {
    getSetting<int>('washThreshold').then((inWashTime) => showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            title: Text('Select Time in Wash'),
            children: List.generate(
              7,
              (i) => RadioListTile(
                title: Text('${i + 1} ${i == 0 ? 'day' : 'days'}'),
                value: i + 1,
                groupValue: inWashTime,
                onChanged: (int value) {
                  setSetting('washThreshold', value);
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ));
  }

  void _selectColorThemeDialog(BuildContext context) {
    _setColorTheme(String value) {
      setSetting('colorTheme', value);
      MyApp.setColorTheme(context);
      Navigator.of(context).pop();
    }

    getSetting<String>('colorTheme').then((theme) => showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            title: Text('Select Color Theme'),
            children: [
              RadioListTile(
                value: 'light',
                groupValue: theme,
                onChanged: (String value) => _setColorTheme(value),
                title: Text('Light'),
              ),
              RadioListTile(
                value: 'dark',
                groupValue: theme,
                onChanged: (String value) => _setColorTheme(value),
                title: Text('Dark'),
              )
            ],
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
            subtitle: 'Set the language you want',
            buttonText: 'Select',
            onButtonTap: () => _selectLanguageDialog(context),
          ),
          Divider(),
          _SettingTile(
            title: 'In Wash Time',
            subtitle: 'How long is your clothing in wash',
            buttonText: 'Select',
            onButtonTap: () => _selectInWashTimeDialog(context),
          ),
          Divider(),
          _SettingTile(
            title: 'Color Theme',
            subtitle: 'Do you like it light or dark',
            buttonText: 'Select',
            onButtonTap: () => _selectColorThemeDialog(context),
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
