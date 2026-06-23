import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_slider.dart';
import '../../../core/widgets/neumorphic_toggle.dart';

class FanControlScreen extends StatefulWidget {
  const FanControlScreen({super.key});

  @override
  State<FanControlScreen> createState() => _FanControlScreenState();
}

class _FanControlScreenState extends State<FanControlScreen> {
  bool _isOn = false;
  double _speed = 2.0; // 1, 2, 3

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
        title: Text('Ceiling Fan', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
        actions: [
          NeumorphicToggle(
            value: _isOn,
            onChanged: (val) => setState(() => _isOn = val),
          ),
          SizedBox(width: 24.w),
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
                width: 200.w,
                height: 200.w,
                padding: EdgeInsets.all(24.w),
                child: Center(
                  child: Icon(
                    Icons.mode_fan_off,
                    size: 80.w,
                    color: _isOn ? AppColors.primary : AppColors.lightTextSecondary,
                  ),
                ),
              ),
              SizedBox(height: 48.h),

              Text('Speed', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 24.h),

              NeumorphicContainer(
                borderRadius: 24.r,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                child: Column(
                  children: [
                    Text('Level ${_speed.toInt()}', style: AppTextStyles.headlineLarge(AppColors.primary)),
                    SizedBox(height: 16.h),
                    Row(
                      children: [
                        Text('1', style: AppTextStyles.labelMedium(AppColors.lightTextSecondary)),
                        Expanded(
                          child: NeumorphicSlider(
                            value: _speed,
                            min: 1,
                            max: 3,
                            onChanged: (val) => setState(() => _speed = val),
                          ),
                        ),
                        Text('3', style: AppTextStyles.labelMedium(AppColors.lightTextSecondary)),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
