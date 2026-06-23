import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class NeumorphicSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double min;
  final double max;

  const NeumorphicSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: Theme.of(context).brightness == Brightness.dark
            ? AppColors.darkSurfaceVariant
            : AppColors.lightSurfaceVariant,
        thumbColor: AppColors.primaryLight,
        trackHeight: 8.0,
      ),
      child: Slider(
        value: value,
        min: min,
        max: max,
        onChanged: onChanged,
      ),
    );
  }
}
