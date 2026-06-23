import 'package:flutter/material.dart';

class AppColors {
  // Light Theme
  static const Color lightBackground = Color(0xFFF9F9FC);
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightShadowDark = Color(0xFFA3B1C6); // Adjusted standard neumorphic
  static const Color lightShadowLight = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF1A1C1E);
  static const Color lightTextSecondary = Color(0xFF494455);
  static const Color lightSurfaceVariant = Color(0xFFE2E2E5);

  // Dark Theme
  static const Color darkBackground = Color(0xFF1A1C1E); // From HTML #1a1c1e
  static const Color darkSurface = Color(0xFF2F3133); // From HTML inverse-surface
  static const Color darkShadowDark = Color(0xFF000000);
  static const Color darkShadowLight = Color(0xFF2D303E); // Standard neumorphic
  static const Color darkTextPrimary = Color(0xFFFFFFFF);
  static const Color darkTextSecondary = Color(0xFFC4C7CA); // From HTML tertiary-fixed-dim
  static const Color darkSurfaceVariant = Color(0xFF44474A);

  // Accents (extracted from top HTML colors)
  static const Color primary = Color(0xFF632CE5); // Most common accent
  static const Color primaryLight = Color(0xFFCDBDFF);
  static const Color primaryDark = Color(0xFF7C4DFF);
  static const Color secondary = Color(0xFF0058BD);
  static const Color error = Color(0xFFBA1A1A);
  static const Color success = Color(0xFF22C55E); // Green found in some box-shadows
}
