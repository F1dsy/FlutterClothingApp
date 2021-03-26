
import 'dart:async';

// ignore: unused_import
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations returned
/// by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// localizationDelegates list, and the locales they support in the app's
/// supportedLocales list. For example:
///
/// ```
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  // ignore: unused_field
  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('da'),
    Locale('de'),
    Locale('en')
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @itemsTab.
  ///
  /// In en, this message translates to:
  /// **'Clothes'**
  String get itemsTab;

  /// No description provided for @outfitsTab.
  ///
  /// In en, this message translates to:
  /// **'Outfits'**
  String get outfitsTab;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @statistics.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// No description provided for @washBasket.
  ///
  /// In en, this message translates to:
  /// **'Wash Basket'**
  String get washBasket;

  /// No description provided for @newCategory.
  ///
  /// In en, this message translates to:
  /// **'New Category'**
  String get newCategory;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @selectLang.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLang;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set the language you want'**
  String get languageSubtitle;

  /// No description provided for @washTitle.
  ///
  /// In en, this message translates to:
  /// **'Wash time'**
  String get washTitle;

  /// No description provided for @washSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How long is your clothing in wash'**
  String get washSubtitle;

  /// No description provided for @washDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Select time in wash'**
  String get washDialogTitle;

  /// Select washThreshold in Settings Screen
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 Day} other{{count} Days}}'**
  String day(int count);

  /// Select ColorTheme Title in Settings Screen
  ///
  /// In en, this message translates to:
  /// **'Color Theme'**
  String get colorThemeTitle;

  /// No description provided for @colorThemeSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Do you like it light or dark'**
  String get colorThemeSubtitle;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @colorThemeDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Select Color Theme'**
  String get colorThemeDialogTitle;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @moveToCategory.
  ///
  /// In en, this message translates to:
  /// **'Move to Category'**
  String get moveToCategory;

  /// No description provided for @addEvent.
  ///
  /// In en, this message translates to:
  /// **'Add Event'**
  String get addEvent;

  /// No description provided for @iceCold.
  ///
  /// In en, this message translates to:
  /// **'Ice Cold ❄'**
  String get iceCold;

  /// No description provided for @cold.
  ///
  /// In en, this message translates to:
  /// **'Cold 🌨'**
  String get cold;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Temperate ☁'**
  String get normal;

  /// No description provided for @warm.
  ///
  /// In en, this message translates to:
  /// **'Warm ☀'**
  String get warm;

  /// No description provided for @hot.
  ///
  /// In en, this message translates to:
  /// **'Hot 🔥'**
  String get hot;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(_lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['da', 'de', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations _lookupAppLocalizations(Locale locale) {
  


// Lookup logic when only language code is specified.
switch (locale.languageCode) {
  case 'da': return AppLocalizationsDa();
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
}


  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
