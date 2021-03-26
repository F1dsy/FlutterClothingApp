import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final int? divisions;
  final double value;
  final double min;
  final double max;
  final String? label;
  final Function(double) onChanged;

  CustomSlider({
    required this.value,
    required this.onChanged,
    this.label,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(),
      child: Slider(
        value: value,
        min: min,
        max: max,
        label: label,
        divisions: divisions,
        onChanged: onChanged,
      ),
    );
  }
}
