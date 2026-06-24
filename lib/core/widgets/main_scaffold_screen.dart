import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

class MainScaffoldScreen extends StatelessWidget {
  const MainScaffoldScreen({
    super.key,
    required this.navigationShell,
  });

  final StatefulNavigationShell navigationShell;

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.darkBackground : AppColors.lightBackground;
    final shadowDark = isDark ? AppColors.darkShadowDark : AppColors.lightShadowDark;
    final shadowLight = isDark ? AppColors.darkShadowLight : AppColors.lightShadowLight;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
          boxShadow: [
            BoxShadow(
              color: shadowDark.withValues(alpha: isDark ? 0.3 : 0.05),
              offset: const Offset(0, -6),
              blurRadius: 12,
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(context, 0, Icons.home_rounded, 'Home', shadowDark, shadowLight, isDark, bg),
                _buildNavItem(context, 1, Icons.grid_view_rounded, 'Rooms', shadowDark, shadowLight, isDark, bg),
                _buildNavItem(context, 2, Icons.devices_rounded, 'Devices', shadowDark, shadowLight, isDark, bg),
                _buildNavItem(context, 3, Icons.bolt_rounded, 'Auto', shadowDark, shadowLight, isDark, bg),
                _buildNavItem(context, 4, Icons.person_rounded, 'Profile', shadowDark, shadowLight, isDark, bg),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, int index, IconData icon, String label, Color shadowDark, Color shadowLight, bool isDark, Color bg) {
    final isSelected = navigationShell.currentIndex == index;

    return GestureDetector(
      onTap: () => _onTap(context, index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        constraints: BoxConstraints(minWidth: 64.w),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: shadowDark.withValues(alpha: isDark ? 0.5 : 0.2),
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected ? AppColors.primary : AppColors.lightTextSecondary,
              size: 24.w,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: AppTextStyles.labelSmall(isSelected ? AppColors.primary : AppColors.lightTextSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
