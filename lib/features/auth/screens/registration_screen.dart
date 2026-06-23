import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 64.h),
                    Text(
                      'Create Account',
                      style: AppTextStyles.headlineLarge(Theme.of(context).colorScheme.onSurface),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Join NexaHome today',
                      style: AppTextStyles.bodyMedium(AppColors.lightTextSecondary),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 48.h),
                    NeumorphicContainer(
                      isPressed: true,
                      borderRadius: 16.r,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Full Name',
                          hintStyle: AppTextStyles.bodyMedium(AppColors.lightTextSecondary),
                          icon: Icon(Icons.person_outline, color: AppColors.primary),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    NeumorphicContainer(
                      isPressed: true,
                      borderRadius: 16.r,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Email Address',
                          hintStyle: AppTextStyles.bodyMedium(AppColors.lightTextSecondary),
                          icon: Icon(Icons.email_outlined, color: AppColors.primary),
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                    NeumorphicContainer(
                      isPressed: true,
                      borderRadius: 16.r,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Password',
                          hintStyle: AppTextStyles.bodyMedium(AppColors.lightTextSecondary),
                          icon: Icon(Icons.lock_outline, color: AppColors.primary),
                        ),
                      ),
                    ),
                    SizedBox(height: 48.h),
                    SizedBox(
                      height: 56.h,
                      child: NeumorphicButton(
                        onTap: () {
                          context.push('/otp');
                        },
                        borderRadius: 16.r,
                        child: Center(
                          child: Text(
                            'Sign Up',
                            style: AppTextStyles.labelMedium(AppColors.primary),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () => context.pop(),
                      child: Text(
                        'Already have an account? Sign In',
                        style: AppTextStyles.bodyMedium(AppColors.primary),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
