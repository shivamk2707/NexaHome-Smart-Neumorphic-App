import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_container.dart';

class ActivityHistoryScreen extends StatelessWidget {
  const ActivityHistoryScreen({super.key});

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
        title: Text('Activity History', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          itemCount: 5,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            return NeumorphicContainer(
              borderRadius: 16.r,
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  NeumorphicContainer(
                    isPressed: true,
                    borderRadius: 8.r,
                    width: 48.w,
                    height: 48.w,
                    child: Center(child: Icon(Icons.history, color: AppColors.primary)),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Smart Lock Unlocked', style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface)),
                        Text('By Alex', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                      ],
                    ),
                  ),
                  Text('2m ago', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
