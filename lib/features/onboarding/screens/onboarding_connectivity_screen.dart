import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';

class OnboardingConnectivityScreen extends StatelessWidget {
  const OnboardingConnectivityScreen({super.key});

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
              NeumorphicContainer(
                width: 120.w,
                height: 120.w,
                shape: BoxShape.circle,
                child: Center(
                  child: Icon(
                    Icons.wifi_tethering,
                    size: 60.w,
                    color: AppColors.primary,
                  ),
                ),
              ),
              SizedBox(height: 48.h),
              Text(
                'Seamless Connectivity',
                style: AppTextStyles.headlineLarge(Theme.of(context).colorScheme.onSurface),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                'Connect all your devices effortlessly for a truly smart home experience.',
                style: AppTextStyles.bodyMedium(AppColors.lightTextSecondary),
                textAlign: TextAlign.center,
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: NeumorphicButton(
                  onTap: () => context.push('/onboarding_automation'),
                  borderRadius: 16.r,
                  child: Center(
                    child: Text(
                      'Next',
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
