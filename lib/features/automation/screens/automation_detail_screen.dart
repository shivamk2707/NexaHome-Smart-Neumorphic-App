import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_toggle.dart';

class AutomationDetailScreen extends StatefulWidget {
  const AutomationDetailScreen({super.key});

  @override
  State<AutomationDetailScreen> createState() => _AutomationDetailScreenState();
}

class _AutomationDetailScreenState extends State<AutomationDetailScreen> {
  bool _isActive = true;

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
        title: Text('Routine Details', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
        actions: [
          NeumorphicToggle(
            value: _isActive,
            onChanged: (val) => setState(() => _isActive = val),
          ),
          SizedBox(width: 24.w),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Good Morning', style: AppTextStyles.headlineLarge(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 32.h),

              Text('When', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
              SizedBox(height: 8.h),
              NeumorphicContainer(
                borderRadius: 16.r,
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    Icon(Icons.access_time, color: AppColors.primary),
                    SizedBox(width: 16.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Time is 7:00 AM', style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface)),
                        Text('Weekdays', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 32.h),
              Text('Do', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
              SizedBox(height: 8.h),
              _buildActionItem(context, 'Smart Blinds', 'Open 100%', Icons.blinds),
              SizedBox(height: 16.h),
              _buildActionItem(context, 'Smart Light', 'Turn On, Brightness 50%', Icons.lightbulb),

              SizedBox(height: 48.h),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: NeumorphicButton(
                  onTap: () {},
                  borderRadius: 16.r,
                  child: Center(
                    child: Text('Edit Routine', style: AppTextStyles.labelMedium(AppColors.primary)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, String device, String action, IconData icon) {
    return NeumorphicContainer(
      borderRadius: 16.r,
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(device, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface)),
                Text(action, style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
