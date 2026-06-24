import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

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
        title: Text('Help & Support', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('FAQ', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 16.h),
              _buildSupportItem(context, 'How to add a new device?', Icons.help_outline),
              SizedBox(height: 16.h),
              _buildSupportItem(context, 'How to share access?', Icons.help_outline),
              SizedBox(height: 16.h),
              _buildSupportItem(context, 'Device offline troubleshooting', Icons.help_outline),

              SizedBox(height: 48.h),
              Text('Contact Us', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 16.h),
              _buildSupportItem(context, 'Live Chat', Icons.chat),
              SizedBox(height: 16.h),
              _buildSupportItem(context, 'Email Support', Icons.email),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportItem(BuildContext context, String text, IconData icon) {
    return NeumorphicButton(
      onTap: () {},
      borderRadius: 16.r,
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          SizedBox(width: 16.w),
          Expanded(child: Text(text, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface))),
          Icon(Icons.chevron_right, color: AppColors.lightTextSecondary),
        ],
      ),
    );
  }
}
