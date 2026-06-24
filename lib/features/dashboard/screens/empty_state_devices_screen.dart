import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';

class EmptyStateDevicesScreen extends StatelessWidget {
  const EmptyStateDevicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                NeumorphicContainer(
                  shape: BoxShape.circle,
                  width: 120.w,
                  height: 120.w,
                  padding: EdgeInsets.all(24.w),
                  child: Center(
                    child: Icon(Icons.devices_other, size: 64.w, color: AppColors.lightTextSecondary),
                  ),
                ),
                SizedBox(height: 32.h),
                Text('No Devices Found', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
                SizedBox(height: 16.h),
                Text('Add your first smart device to get started.', style: AppTextStyles.bodyMedium(AppColors.lightTextSecondary), textAlign: TextAlign.center),
                SizedBox(height: 48.h),
                NeumorphicButton(
                  onTap: () => context.push('/add_device'),
                  borderRadius: 16.r,
                  padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                  child: Text('Add Device', style: AppTextStyles.labelMedium(AppColors.primary)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
