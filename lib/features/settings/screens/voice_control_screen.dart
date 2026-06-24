import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_button.dart';

class VoiceControlScreen extends StatelessWidget {
  const VoiceControlScreen({super.key});

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
        title: Text('Voice Control', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 32.h),
              NeumorphicButton(
                onTap: () {},
                shape: BoxShape.circle,
                padding: EdgeInsets.all(48.w),
                child: Center(
                  child: Icon(Icons.mic, size: 64.w, color: AppColors.primary),
                ),
              ),
              SizedBox(height: 48.h),
              Text('Listening...', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 16.h),
              Text('Try saying: "Turn off all lights"', style: AppTextStyles.bodyMedium(AppColors.lightTextSecondary)),
            ],
          ),
        ),
      ),
    );
  }
}
