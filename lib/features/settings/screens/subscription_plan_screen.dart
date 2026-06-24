import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';

class SubscriptionPlanScreen extends StatelessWidget {
  const SubscriptionPlanScreen({super.key});

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
        title: Text('Subscription', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NeumorphicContainer(
                borderRadius: 24.r,
                padding: EdgeInsets.all(32.w),
                child: Column(
                  children: [
                    Icon(Icons.workspace_premium, size: 64.w, color: AppColors.primary),
                    SizedBox(height: 16.h),
                    Text('NexaHome Premium', style: AppTextStyles.headlineLarge(Theme.of(context).colorScheme.onSurface)),
                    SizedBox(height: 8.h),
                    Text('\$9.99 / month', style: AppTextStyles.display(AppColors.primary)),
                    SizedBox(height: 32.h),
                    _buildFeature(context, 'Unlimited Automation Rules'),
                    _buildFeature(context, 'Cloud Camera Storage (30 Days)'),
                    _buildFeature(context, 'Priority Support'),
                    _buildFeature(context, 'Advanced Energy Analytics'),
                  ],
                ),
              ),
              SizedBox(height: 48.h),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: NeumorphicButton(
                  onTap: () {},
                  borderRadius: 16.r,
                  child: Center(
                    child: Text('Upgrade to Premium', style: AppTextStyles.labelMedium(AppColors.primary)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeature(BuildContext context, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppColors.primary),
          SizedBox(width: 16.w),
          Expanded(child: Text(text, style: AppTextStyles.bodyMedium(Theme.of(context).colorScheme.onSurface))),
        ],
      ),
    );
  }
}
