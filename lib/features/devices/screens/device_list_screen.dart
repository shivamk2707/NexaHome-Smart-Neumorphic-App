import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_toggle.dart';
import '../bloc/device_cubit.dart';
import '../../rooms/bloc/room_cubit.dart';
import '../../../data/models/device_model.dart' as dm;
import '../../../data/models/room_model.dart';

class DeviceListScreen extends StatelessWidget {
  const DeviceListScreen({super.key});

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
        title: Text('All Devices', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => context.push('/add_device'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: BlocBuilder<DeviceCubit, List<dm.DeviceModel>>(
            builder: (context, devices) {
              if (devices.isEmpty) {
                return Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 100.h),
                    child: Text('No devices found', style: AppTextStyles.bodyLarge(AppColors.lightTextSecondary)),
                  ),
                );
              }
              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: devices.length,
                separatorBuilder: (context, index) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  final device = devices[index];
                  final rooms = context.read<RoomCubit>().state;
                  final roomName = rooms.firstWhere((r) => r.id == device.roomId, orElse: () => const RoomModel(id: '', name: 'Unassigned', icon: Icons.help)).name;

                  return _buildDeviceListItem(context, device, roomName)
                    .animate()
                    .fade(duration: 400.ms, delay: (index * 50).ms)
                    .slideY(begin: 0.1, end: 0, duration: 400.ms, curve: Curves.easeOut);
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceListItem(BuildContext context, dm.DeviceModel device, String roomName) {
    return NeumorphicButton(
      onTap: () {
        if (device.type == dm.DeviceType.ac) context.push('/ac_control/${device.id}');
        if (device.type == dm.DeviceType.light) context.push('/light_control/${device.id}');
        if (device.type == dm.DeviceType.lock) context.push('/lock_control/${device.id}');
        if (device.type == dm.DeviceType.fan) context.push('/fan_control/${device.id}');
      },
      borderRadius: 24.r,
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          NeumorphicContainer(
            isPressed: device.isOn,
            borderRadius: 16.r,
            padding: EdgeInsets.all(12.w),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: Icon(
                device.icon,
                key: ValueKey('${device.id}_${device.isOn}'),
                color: device.isOn ? AppColors.primary : AppColors.lightTextSecondary
              ),
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(device.name, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface)),
                SizedBox(height: 4.h),
                Text(roomName, style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
              ],
            ),
          ),
          NeumorphicToggle(
            value: device.isOn,
            onChanged: (val) => context.read<DeviceCubit>().toggleDevice(device.id),
          ),
        ],
      ),
    );
  }
}
