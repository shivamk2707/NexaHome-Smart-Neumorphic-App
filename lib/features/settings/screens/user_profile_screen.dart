import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

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
        title: Text('Profile', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              SizedBox(height: 32.h),
              NeumorphicContainer(
                shape: BoxShape.circle,
                width: 120.w,
                height: 120.w,
                padding: EdgeInsets.all(8.w),
                child: NeumorphicContainer(
                  isPressed: true,
                  shape: BoxShape.circle,
                  child: Center(
                    child: Icon(Icons.person, size: 64.w, color: AppColors.primary),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Text('Alex Johnson', style: AppTextStyles.headlineLarge(Theme.of(context).colorScheme.onSurface)),
              Text('alex.johnson@example.com', style: AppTextStyles.bodyMedium(AppColors.lightTextSecondary)),
              SizedBox(height: 48.h),

              _buildTextField(context, 'Full Name', 'Alex Johnson', Icons.person_outline),
              SizedBox(height: 24.h),
              _buildTextField(context, 'Email Address', 'alex.johnson@example.com', Icons.email_outlined),
              SizedBox(height: 24.h),
              _buildTextField(context, 'Phone Number', '+1 234 567 8900', Icons.phone_outlined),

              SizedBox(height: 48.h),
              SizedBox(
                height: 56.h,
                child: NeumorphicButton(
                  onTap: () {},
                  borderRadius: 16.r,
                  child: Center(
                    child: Text('Save Changes', style: AppTextStyles.labelMedium(AppColors.primary)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, String initialValue, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
        SizedBox(height: 8.h),
        NeumorphicContainer(
          isPressed: true,
          borderRadius: 16.r,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(icon, color: AppColors.primary),
            ),
            style: AppTextStyles.bodyMedium(Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    );
  }
}
