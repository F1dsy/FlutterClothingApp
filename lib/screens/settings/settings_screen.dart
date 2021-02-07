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

  void _selectColorThemeDialog(BuildContext context) {
    _setColorTheme(String value) {
      setSetting('colorTheme', value);
      MyApp.setColorTheme(context);
      Navigator.of(context).pop();
    }

    getSetting<String>('colorTheme').then((theme) => showDialog(
          context: context,
          builder: (context) => SimpleDialog(
            title: Text(AppLocalizations.of(context).colorThemeDialogTitle),
            children: [
              RadioListTile(
                value: 'light',
                groupValue: theme,
                onChanged: (String value) => _setColorTheme(value),
                title: Text(AppLocalizations.of(context).light),
              ),
              RadioListTile(
                value: 'dark',
                groupValue: theme,
                onChanged: (String value) => _setColorTheme(value),
                title: Text(AppLocalizations.of(context).dark),
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
            title: AppLocalizations.of(context).language,
            subtitle: AppLocalizations.of(context).languageSubtitle,
            onButtonTap: () => _selectLanguageDialog(context),
          ),
          Divider(),
          _SettingTile(
            title: AppLocalizations.of(context).colorThemeTitle,
            subtitle: AppLocalizations.of(context).colorThemeSubtitle,
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

  final Function onButtonTap;
  _SettingTile({this.title, this.onButtonTap, this.subtitle});
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
        child: Text(AppLocalizations.of(context).select),
      ),
    );
  }
}
