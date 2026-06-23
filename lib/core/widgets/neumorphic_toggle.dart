import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import 'neumorphic_container.dart';

class NeumorphicToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const NeumorphicToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(!value),
      child: NeumorphicContainer(
        isPressed: true, // Trough is inset
        borderRadius: 20,
        width: 60,
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              left: value ? 28 : 0,
              child: NeumorphicContainer(
                isPressed: false,
                shape: BoxShape.circle,
                width: 24,
                height: 24,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: value ? AppColors.primary : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
