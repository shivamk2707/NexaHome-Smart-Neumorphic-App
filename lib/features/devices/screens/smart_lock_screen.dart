import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';

class SmartLockScreen extends StatefulWidget {
  const SmartLockScreen({super.key});

  @override
  State<SmartLockScreen> createState() => _SmartLockScreenState();
}

class _SmartLockScreenState extends State<SmartLockScreen> {
  bool _isLocked = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Front Door', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              SizedBox(height: 32.h),
              NeumorphicButton(
                onTap: () => setState(() => _isLocked = !_isLocked),
                shape: BoxShape.circle,
                padding: EdgeInsets.all(40.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _isLocked ? Icons.lock : Icons.lock_open,
                      size: 80.w,
                      color: _isLocked ? AppColors.primary : AppColors.lightTextSecondary,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      _isLocked ? 'LOCKED' : 'UNLOCKED',
                      style: AppTextStyles.labelMedium(_isLocked ? AppColors.primary : AppColors.lightTextSecondary),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 48.h),

              Text('Access Log', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 16.h),

              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  return NeumorphicContainer(
                    borderRadius: 16.r,
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        Icon(Icons.person, color: AppColors.primary),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Alex', style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface)),
                            Text('Unlocked front door', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                          ],
                        ),
                        Spacer(),
                        Text('10:30 AM', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
