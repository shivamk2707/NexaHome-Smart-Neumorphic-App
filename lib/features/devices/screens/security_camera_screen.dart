import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';

class SecurityCameraScreen extends StatelessWidget {
  const SecurityCameraScreen({super.key});

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
        title: Text('Front Camera', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NeumorphicContainer(
                borderRadius: 24.r,
                height: 250.h,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(color: Colors.black),
                      Center(child: Icon(Icons.videocam, color: Colors.white54, size: 64.w)),
                      Positioned(
                        top: 16.h,
                        right: 16.w,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(width: 8.w, height: 8.w, decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.white)),
                              SizedBox(width: 4.w),
                              Text('LIVE', style: AppTextStyles.labelSmall(Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildControlButton(context, Icons.mic, 'Talk'),
                  _buildControlButton(context, Icons.camera_alt, 'Record'),
                  _buildControlButton(context, Icons.camera, 'Snapshot'),
                  _buildControlButton(context, Icons.notifications, 'Alert'),
                ],
              ),

              SizedBox(height: 48.h),
              Text('Recent Events', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
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
                        NeumorphicContainer(
                          isPressed: true,
                          borderRadius: 8.r,
                          width: 48.w,
                          height: 48.w,
                          child: Center(child: Icon(Icons.directions_run, color: AppColors.primary)),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Motion Detected', style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface)),
                              Text('Front Door', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                            ],
                          ),
                        ),
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

  Widget _buildControlButton(BuildContext context, IconData icon, String label) {
    return Column(
      children: [
        NeumorphicButton(
          onTap: () {},
          shape: BoxShape.circle,
          padding: EdgeInsets.all(20.w),
          child: Icon(icon, color: AppColors.primary),
        ),
        SizedBox(height: 8.h),
        Text(label, style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
      ],
    );
  }
}
