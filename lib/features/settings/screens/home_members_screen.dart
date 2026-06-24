import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';

class HomeMembersScreen extends StatelessWidget {
  const HomeMembersScreen({super.key});

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
        title: Text('Home Members', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
        actions: [
          IconButton(
            icon: Icon(Icons.person_add, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          itemCount: 3,
          separatorBuilder: (context, index) => SizedBox(height: 16.h),
          itemBuilder: (context, index) {
            final roles = ['Owner', 'Admin', 'Member'];
            return NeumorphicContainer(
              borderRadius: 16.r,
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  NeumorphicContainer(
                    isPressed: true,
                    borderRadius: 24.r,
                    width: 48.w,
                    height: 48.w,
                    child: Center(child: Icon(Icons.person, color: AppColors.primary)),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Member $index', style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface)),
                        Text(roles[index], style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                      ],
                    ),
                  ),
                  Icon(Icons.more_vert, color: AppColors.lightTextSecondary),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
