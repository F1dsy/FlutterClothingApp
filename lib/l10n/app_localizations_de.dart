
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: unnecessary_brace_in_string_interps

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get calendar => 'Kalender';

  @override
  String get itemsTab => 'Kleidung';

  @override
  String get outfitsTab => 'Outfits';

  @override
  String get settings => 'Einstellungen';

  @override
  String get statistics => 'Statistik';

  @override
  String get washBasket => 'Wäschekorb';

  @override
  String get newCategory => 'Neue Kategorie';

  @override
  String get select => 'Auswählen';

  @override
  String get selectLang => 'Sprache Wählen';

  @override
  String get language => 'Sprache';

  @override
  String get languageSubtitle => 'Wähle deine Sprache';

  @override
  String get washTitle => 'Wäschezeit';

  @override
  String get washSubtitle => 'Wie lange ist deine Kleidung in der Wäsche';

  @override
  String get washDialogTitle => 'Tage in Wäsche wählen';

  @override
  String day(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '${count} Tage',
    );
  }

  @override
  String get colorThemeTitle => 'Farbthema';

  @override
  String get colorThemeSubtitle => 'Magst du es Hell oder Dunkel';

  @override
  String get light => 'Hell';

  @override
  String get dark => 'Dunkel';

  @override
  String get colorThemeDialogTitle => 'Farbthema auswählen';

  @override
  String get delete => 'Löschen';

  @override
  String get moveToCategory => 'Kategorie verschieben';

  @override
  String get addEvent => 'Neues Event';
}
