import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';
import '../models/item_data.dart';

// Temperature sliderValueToTemperatureEnum(double value) {
//   int intValue = value.toInt();
//   return Temperature.values[intValue];
// }

// Formality sliderValueToFormalityEnum(double value) {
//   int intValue = value.toInt();
//   return Formality.values[intValue];
// }

String? getSliderLabel(BuildContext context, Temperature temperature) {
  switch (temperature) {
    case Temperature.IceCold:
      return AppLocalizations.of(context)!.iceCold;
    case Temperature.Cold:
      return AppLocalizations.of(context)!.cold;
    case Temperature.Normal:
      return AppLocalizations.of(context)!.normal;
    case Temperature.Warm:
      return AppLocalizations.of(context)!.warm;
    case Temperature.Hot:
      return AppLocalizations.of(context)!.hot;

    default:
  }
}
