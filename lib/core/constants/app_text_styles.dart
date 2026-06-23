import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyles {
  static TextStyle display(Color color) => GoogleFonts.inter(
        fontSize: 48.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.02,
        color: color,
        height: 56 / 48,
      );

  static TextStyle headlineLarge(Color color) => GoogleFonts.inter(
        fontSize: 32.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.01,
        color: color,
        height: 40 / 32,
      );

  static TextStyle headlineMedium(Color color) => GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: color,
        height: 28 / 20,
      );

  static TextStyle headlineSmall(Color color) => GoogleFonts.inter(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: color,
        height: 32 / 24,
      );

  static TextStyle bodyLarge(Color color) => GoogleFonts.inter(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: color,
        height: 26 / 18,
      );

  static TextStyle bodyMedium(Color color) => GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: color,
        height: 24 / 16,
      );

  static TextStyle labelMedium(Color color) => GoogleFonts.inter(
        fontSize: 14.sp,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.01,
        color: color,
        height: 20 / 14,
      );

  static TextStyle labelSmall(Color color) => GoogleFonts.inter(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.05,
        color: color,
        height: 16 / 12,
      );
}
