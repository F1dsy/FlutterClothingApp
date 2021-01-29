
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: unnecessary_brace_in_string_interps

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get calendar => 'Calendar';

  @override
  String get itemsTab => 'Clothes';

  @override
  String get outfitsTab => 'Outfits';

  @override
  String get settings => 'Settings';

  @override
  String get statistics => 'Statistics';

  @override
  String get washBasket => 'Wash Basket';

  @override
  String get newCategory => 'New Category';

  @override
  String get select => 'Select';

  @override
  String get selectLang => 'Select Language';

  @override
  String get language => 'Language';

  @override
  String get languageSubtitle => 'Set the language you want';

  @override
  String get washTitle => 'Wash time';

  @override
  String get washSubtitle => 'How long is your clothing in wash';

  @override
  String get washDialogTitle => 'Select time in wash';

  @override
  String day(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '${count} Days',
    );
  }

  @override
  String get colorThemeTitle => 'Color Theme';

  @override
  String get colorThemeSubtitle => 'Do you like it light or dark';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get colorThemeDialogTitle => 'Select Color Theme';

  @override
  String get delete => 'Delete';

  @override
  String get moveToCategory => 'Move to Category';

  @override
  String get addEvent => 'Add Event';
}
