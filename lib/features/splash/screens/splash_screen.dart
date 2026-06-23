import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../data/services/preferences_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkStatus();
  }

  Future<void> _checkStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    if (!mounted) return;

    final prefs = PreferencesService();
    final hasOnboarded = await prefs.isOnboardingDone();

    if (!mounted) return;
    if (hasOnboarded) {
      context.go('/login');
    } else {
      context.go('/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Atmospheric Glow Background
            Positioned(
              top: -100.h,
              left: -100.w,
              child: Container(
                width: 300.w,
                height: 300.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.05),
                ),
              ).animate(onPlay: (controller) => controller.repeat(reverse: true))
               .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: const Duration(seconds: 4))
               .fade(begin: 0.3, end: 0.6, duration: const Duration(seconds: 4)),
            ),
            Positioned(
              bottom: -100.h,
              right: -100.w,
              child: Container(
                width: 400.w,
                height: 400.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.secondary.withValues(alpha: 0.05),
                ),
              ),
            ),
            // Main Content Container
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated House Icon Container
                NeumorphicContainer(
                  width: 96.w,
                  height: 96.w,
                  shape: BoxShape.circle,
                  child: Center(
                    child: Icon(
                      Icons.home_rounded,
                      size: 48.w,
                      color: AppColors.primary,
                    ),
                  ),
                ).animate(onPlay: (controller) => controller.repeat(reverse: true))
                 .moveY(begin: 0, end: -10, duration: const Duration(milliseconds: 1500), curve: Curves.easeInOut),
                SizedBox(height: 40.h),
                // Branded Logo Text
                Text(
                  'NexaHome',
                  style: AppTextStyles.display(AppColors.primary).copyWith(
                    fontSize: 32.sp, // Adjusted to match mobile headline
                  ),
                ).animate().fade(duration: const Duration(seconds: 1)).slideY(begin: 0.5, end: 0),
                SizedBox(height: 8.h),
                // Neomorphic Logo Sub-Container
                NeumorphicContainer(
                  isPressed: true,
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                  borderRadius: 999,
                  child: Text(
                    'INTELLIGENCE',
                    style: AppTextStyles.labelMedium(AppColors.lightTextSecondary).copyWith(
                      letterSpacing: 2.0,
                    ),
                  ),
                ).animate().fade(delay: const Duration(milliseconds: 500), duration: const Duration(seconds: 1)),
              ],
            ),
            // Bottom Loading Section
            Positioned(
              bottom: 64.h,
              child: Column(
                children: [
                  NeumorphicContainer(
                    isPressed: true,
                    width: 240.w,
                    height: 6.h,
                    borderRadius: 999,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: 240.w,
                        height: 6.h,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(alpha: 0.4),
                              blurRadius: 12,
                            ),
                          ],
                        ),
                      ).animate()
                       .scaleX(begin: 0, end: 1, duration: const Duration(seconds: 3), curve: Curves.easeOutCubic, alignment: Alignment.centerLeft),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Starting control systems...',
                    style: AppTextStyles.labelSmall(AppColors.lightTextSecondary),
                  ),
                  SizedBox(height: 32.h),
                  Text(
                    'v1.0.4',
                    style: AppTextStyles.labelSmall(AppColors.lightTextSecondary.withValues(alpha: 0.4)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
