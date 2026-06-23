import 'package:flutter/animation.dart';

class AnimationUtils {
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 300);
  static const Duration slow = Duration(milliseconds: 500);

  static const Curve standard = Curves.easeInOut;
  static const Curve decelerate = Curves.decelerate;

  // Custom curve extracted from HTML `cubic-bezier(0.4, 0, 0.2, 1)`
  static const Curve customCubic = Cubic(0.4, 0.0, 0.2, 1.0);
}
