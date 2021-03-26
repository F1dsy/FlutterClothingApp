import '../models/item_data.dart';

String? getSliderLabel(double value) {
  int intValue = value.toInt();
  return Temperature.values[intValue]
      .toString()
      .replaceFirst('Temperature.', '');
}
