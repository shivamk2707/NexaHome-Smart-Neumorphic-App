import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';

class CreateNewSceneScreen extends StatelessWidget {
  const CreateNewSceneScreen({super.key});

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
        title: Text('New Scene', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Scene Name', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
              SizedBox(height: 8.h),
              NeumorphicContainer(
                isPressed: true,
                borderRadius: 16.r,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'e.g. Movie Time',
                    hintStyle: AppTextStyles.bodyMedium(AppColors.lightTextSecondary),
                  ),
                  style: AppTextStyles.bodyMedium(Theme.of(context).colorScheme.onSurface),
                ),
              ),

              SizedBox(height: 32.h),
              Text('Icon', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
              SizedBox(height: 8.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    _buildIconSelector(context, Icons.movie, true),
                    _buildIconSelector(context, Icons.restaurant, false),
                    _buildIconSelector(context, Icons.celebration, false),
                    _buildIconSelector(context, Icons.wb_sunny, false),
                    _buildIconSelector(context, Icons.nights_stay, false),
                  ],
                ),
              ),

              SizedBox(height: 32.h),
              Text('Actions', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
              SizedBox(height: 8.h),
              NeumorphicButton(
                onTap: () {},
                borderRadius: 16.r,
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: AppColors.primary),
                    SizedBox(width: 8.w),
                    Text('Add Action', style: AppTextStyles.labelMedium(AppColors.primary)),
                  ],
                ),
              ),

              SizedBox(height: 48.h),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: NeumorphicButton(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: 16.r,
                  child: Center(
                    child: Text('Save Scene', style: AppTextStyles.labelMedium(AppColors.primary)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconSelector(BuildContext context, IconData icon, bool isSelected) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: NeumorphicButton(
        onTap: () {},
        shape: BoxShape.circle,
        padding: EdgeInsets.all(16.w),
        child: Icon(icon, color: isSelected ? AppColors.primary : AppColors.lightTextSecondary),
      ),
    );
  }
}
