import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../data/services/preferences_service.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              // Icon
              NeumorphicContainer(
                width: 120.w,
                height: 120.w,
                shape: BoxShape.circle,
                child: Center(
                  child: Icon(
                    Icons.maps_home_work_rounded,
                    size: 60.w,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(height: 48.h),
              Text(
                'Welcome to NexaHome',
                style: AppTextStyles.headlineLarge(Theme.of(context).colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                'Experience the ultimate comfort and security with NexaHome\'s premium automation.',
                style: AppTextStyles.bodyMedium(AppColors.lightTextSecondary),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: NeumorphicButton(
                  onTap: () async {
                    final prefs = PreferencesService();
                    await prefs.setOnboardingDone();
                    if (context.mounted) {
                      context.go('/login');
                    }
                  },
                  borderRadius: 16.r,
                  child: Center(
                    child: Text(
                      'Get Started',
                      style: AppTextStyles.labelMedium(AppColors.primary),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 48.h),
            ],
          ),
        ),
      ),
    );
  }
}
