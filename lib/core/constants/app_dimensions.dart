import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDimensions {
  // Spacing
  static double get xs => 4.w;
  static double get sm => 8.w;
  static double get md => 16.w;
  static double get lg => 24.w;
  static double get xl => 32.w;

  static double get gutter => 16.w;
  static double get marginMobile => 20.w;
  static double get marginDesktop => 40.w;

  // Radius
  static double get radiusDefault => 4.r; // 0.25rem
  static double get radiusLg => 8.r; // 0.5rem
  static double get radiusXl => 12.r; // 0.75rem
  static double get radiusFull => 9999.r; // 9999px
}
