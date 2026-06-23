import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class NeumorphicContainer extends StatelessWidget {
  final Widget child;
  final bool isPressed;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final BoxShape shape;

  const NeumorphicContainer({
    super.key,
    required this.child,
    this.isPressed = false,
    this.borderRadius = 8.0,
    this.padding,
    this.width,
    this.height,
    this.shape = BoxShape.rectangle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final shadowDark = isDark ? AppColors.darkShadowDark : AppColors.lightShadowDark;
    final shadowLight = isDark ? AppColors.darkShadowLight : AppColors.lightShadowLight;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        shape: shape,
        borderRadius: shape == BoxShape.circle ? null : BorderRadius.circular(borderRadius),
        boxShadow: isPressed
            ? [
                BoxShadow(
                  color: shadowDark.withValues(alpha: isDark ? 0.5 : 0.2),
                  offset: const Offset(2, 2),
                  blurRadius: 4,
                ),
              ]
            : [
                BoxShadow(
                  color: shadowDark.withValues(alpha: isDark ? 0.3 : 0.2),
                  offset: const Offset(6, 6),
                  blurRadius: 12,
                ),
                BoxShadow(
                  color: shadowLight.withValues(alpha: isDark ? 0.05 : 0.8),
                  offset: const Offset(-6, -6),
                  blurRadius: 12,
                ),
              ],
      ),
      child: child,
    );
  }
}
