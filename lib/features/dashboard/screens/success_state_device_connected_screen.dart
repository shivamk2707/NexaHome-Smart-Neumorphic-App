import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';

class SuccessStateDeviceConnectedScreen extends StatelessWidget {
  const SuccessStateDeviceConnectedScreen({super.key});

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
                    child: Icon(Icons.check_circle, size: 64.w, color: AppColors.success),
                  ),
                ),
                SizedBox(height: 32.h),
                Text('Device Connected!', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
                SizedBox(height: 16.h),
                Text('Your new smart device is ready to use.', style: AppTextStyles.bodyMedium(AppColors.lightTextSecondary), textAlign: TextAlign.center),
                SizedBox(height: 48.h),
                NeumorphicButton(
                  onTap: () => context.go('/dashboard'),
                  borderRadius: 16.r,
                  padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                  child: Text('Done', style: AppTextStyles.labelMedium(AppColors.primary)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
