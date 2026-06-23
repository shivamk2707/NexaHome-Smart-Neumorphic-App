import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_toggle.dart';

class AcControlScreen extends StatefulWidget {
  const AcControlScreen({super.key});

  @override
  State<AcControlScreen> createState() => _AcControlScreenState();
}

class _AcControlScreenState extends State<AcControlScreen> {
  bool _isOn = true;
  double _temperature = 24.0;

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
        title: Text('Smart AC', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
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
              // Dial replacement (simplification)
              NeumorphicContainer(
                shape: BoxShape.circle,
                width: 280.w,
                height: 280.w,
                padding: EdgeInsets.all(24.w),
                child: NeumorphicContainer(
                  isPressed: true,
                  shape: BoxShape.circle,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${_temperature.toInt()}°C',
                          style: AppTextStyles.display(Theme.of(context).colorScheme.onSurface).copyWith(fontSize: 64.sp),
                        ),
                        Text('Cooling', style: AppTextStyles.labelMedium(AppColors.primary)),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 48.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  NeumorphicButton(
                    onTap: () {
                      if (_temperature > 16) setState(() => _temperature--);
                    },
                    shape: BoxShape.circle,
                    padding: EdgeInsets.all(16.w),
                    child: Icon(Icons.remove, color: Theme.of(context).colorScheme.onSurface),
                  ),
                  SizedBox(width: 48.w),
                  NeumorphicButton(
                    onTap: () {
                      if (_temperature < 30) setState(() => _temperature++);
                    },
                    shape: BoxShape.circle,
                    padding: EdgeInsets.all(16.w),
                    child: Icon(Icons.add, color: Theme.of(context).colorScheme.onSurface),
                  ),
                ],
              ),

              SizedBox(height: 48.h),
              // Modes
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildModeButton(context, Icons.ac_unit, 'Cool', true),
                  _buildModeButton(context, Icons.water_drop_outlined, 'Dry', false),
                  _buildModeButton(context, Icons.air, 'Fan', false),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModeButton(BuildContext context, IconData icon, String label, bool isActive) {
    return Column(
      children: [
        NeumorphicContainer(
          isPressed: isActive,
          shape: BoxShape.circle,
          padding: EdgeInsets.all(20.w),
          child: Icon(icon, color: isActive ? AppColors.primary : AppColors.lightTextSecondary),
        ),
        SizedBox(height: 12.h),
        Text(label, style: AppTextStyles.labelSmall(isActive ? AppColors.primary : AppColors.lightTextSecondary)),
      ],
    );
  }
}
