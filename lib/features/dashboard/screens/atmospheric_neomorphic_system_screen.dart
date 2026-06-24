import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

class AtmosphericNeomorphicSystemScreen extends StatelessWidget {
  const AtmosphericNeomorphicSystemScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('System Overview', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              Text('All Systems Normal', style: AppTextStyles.bodyMedium(AppColors.success)),
              // The main app utilizes these widgets throughout, this is a placeholder
              // representing the generic atmospheric/ambient background component.
            ],
          ),
        ),
      ),
    );
  }
}
