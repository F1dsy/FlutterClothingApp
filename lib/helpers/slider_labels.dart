import '../models/item_data.dart';

Temperature sliderValueToTemperatureEnum(double value) {
  int intValue = value.toInt();
  return Temperature.values[intValue];
}

Formality sliderValueToFormalityEnum(double value) {
  int intValue = value.toInt();
  return Formality.values[intValue];
}

String? getSliderLabel(double value) {
  int intValue = value.toInt();
  return Temperature.values[intValue]
      .toString()
      .replaceFirst('Temperature.', '');
}
