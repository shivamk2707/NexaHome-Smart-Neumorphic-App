import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/device_cubit.dart';
import '../../../data/models/device_model.dart' as dm;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_slider.dart';
import '../../../core/widgets/neumorphic_toggle.dart';

class SmartLightControlScreen extends StatefulWidget {
  final String deviceId;
  const SmartLightControlScreen({super.key, required this.deviceId});

  @override
  State<SmartLightControlScreen> createState() => _SmartLightControlScreenState();
}

class _SmartLightControlScreenState extends State<SmartLightControlScreen> {
  String get deviceId => widget.deviceId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceCubit, List<dm.DeviceModel>>(
      builder: (context, devices) {
        final device = devices.firstWhere((d) => d.id == deviceId, orElse: () => const dm.DeviceModel(id: '', name: '', roomId: '', type: dm.DeviceType.light, icon: Icons.error));
        final isOn = device.isOn;
        final brightness = device.brightness ?? 75.0;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(device.name, style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
            actions: [
              NeumorphicToggle(
                value: isOn,
                onChanged: (val) => context.read<DeviceCubit>().toggleDevice(deviceId),
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
                        Icons.lightbulb,
                        size: 80.w,
                        color: isOn ? AppColors.primary : AppColors.lightTextSecondary,
                      ),
                    ),
                  ),
                  SizedBox(height: 48.h),

                  Text('Brightness', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
                  SizedBox(height: 24.h),

                  NeumorphicContainer(
                    borderRadius: 24.r,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                    child: Column(
                      children: [
                        Text('${brightness.toInt()}%', style: AppTextStyles.headlineLarge(AppColors.primary)),
                        SizedBox(height: 16.h),
                        Row(
                          children: [
                            Icon(Icons.brightness_low, color: AppColors.lightTextSecondary),
                            Expanded(
                              child: NeumorphicSlider(
                                value: brightness,
                                onChanged: (val) => context.read<DeviceCubit>().updateDevice(device.copyWith(brightness: val)),
                              ),
                            ),
                            Icon(Icons.brightness_high, color: AppColors.lightTextSecondary),
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
    );
  }
}
