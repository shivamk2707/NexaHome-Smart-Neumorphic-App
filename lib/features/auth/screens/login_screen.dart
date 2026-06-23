import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../data/services/preferences_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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
                      'Welcome Back',
                      style: AppTextStyles.headlineLarge(Theme.of(context).colorScheme.onSurface),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Sign in to control your smart home',
                      style: AppTextStyles.bodyMedium(AppColors.lightTextSecondary),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 48.h),
                    NeumorphicContainer(
                      isPressed: true,
                      borderRadius: 16.r,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: TextField(
                        controller: _emailController,
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
                        controller: _passwordController,
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
                        onTap: () async {
                          final prefs = PreferencesService();
                          await prefs.setAuthenticated(true);
                          if (context.mounted) {
                            context.go('/dashboard');
                          }
                        },
                        borderRadius: 16.r,
                        child: Center(
                          child: Text(
                            'Sign In',
                            style: AppTextStyles.labelMedium(AppColors.primary),
                          ),
                        ),
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        context.push('/registration');
                      },
                      child: Text(
                        'Don\'t have an account? Sign Up',
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
