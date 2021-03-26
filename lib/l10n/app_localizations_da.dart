
// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: unnecessary_brace_in_string_interps

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get home => 'Hjem';

  @override
  String get calendar => 'Kalender';

  @override
  String get itemsTab => 'Tøj';

  @override
  String get outfitsTab => 'Outfits';

  @override
  String get settings => 'Indstillinger';

  @override
  String get statistics => 'Statistik';

  @override
  String get washBasket => 'Vaskekurv';

  @override
  String get newCategory => 'Ny Kategori';

  @override
  String get select => 'Vælg';

  @override
  String get selected => 'Valgt';

  @override
  String get selectLang => 'Vælg Sprog';

  @override
  String get language => 'Sprog';

  @override
  String get languageSubtitle => 'Sæt det sprog du vil';

  @override
  String get washTitle => 'Vasketid';

  @override
  String get washSubtitle => 'Hvor længe har du dit tøj i vasken';

  @override
  String get washDialogTitle => 'Vælg dage in vaskekurv';

  @override
  String day(int count) {
    return intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '${count} Dage',
    );
  }

  @override
  String get colorThemeTitle => 'Farvetema';

  @override
  String get colorThemeSubtitle => 'Kan du lide det lyst eller mørkt';

  @override
  String get light => 'Lys';

  @override
  String get dark => 'Mørk';

  @override
  String get colorThemeDialogTitle => 'Vælg farvetema';

  @override
  String get delete => 'Slet';

  @override
  String get moveToCategory => 'Flyt kategori';

  @override
  String get addEvent => 'Ny Event';

  @override
  String get iceCold => 'Iskold ❄';

  @override
  String get cold => 'Kold 🌨';

  @override
  String get normal => 'Normal ☁';

  @override
  String get warm => 'Varm ☀';

  @override
  String get hot => 'Hed 🔥';
}
