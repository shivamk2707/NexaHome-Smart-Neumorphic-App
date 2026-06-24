import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/device_cubit.dart';
import '../../../data/models/device_model.dart' as dm;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_toggle.dart';

class AcControlScreen extends StatefulWidget {
  final String deviceId;
  const AcControlScreen({super.key, required this.deviceId});

  @override
  State<AcControlScreen> createState() => _AcControlScreenState();
}

class _AcControlScreenState extends State<AcControlScreen> {
  String get deviceId => widget.deviceId;
  // Device ID would ideally be passed in, hardcoding 'd1' for AC

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceCubit, List<dm.DeviceModel>>(
      builder: (context, devices) {
        final device = devices.firstWhere((d) => d.id == deviceId, orElse: () => const dm.DeviceModel(id: '', name: '', roomId: '', type: dm.DeviceType.ac, icon: Icons.error));
        final isOn = device.isOn;
        final temperature = device.temperature ?? 24.0;

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
                              '${temperature.toInt()}°C',
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
                          if (temperature > 16) {
                            context.read<DeviceCubit>().updateDevice(device.copyWith(temperature: temperature - 1));
                          }
                        },
                        shape: BoxShape.circle,
                        padding: EdgeInsets.all(16.w),
                        child: Icon(Icons.remove, color: Theme.of(context).colorScheme.onSurface),
                      ),
                      SizedBox(width: 48.w),
                      NeumorphicButton(
                        onTap: () {
                          if (temperature < 30) {
                            context.read<DeviceCubit>().updateDevice(device.copyWith(temperature: temperature + 1));
                          }
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
