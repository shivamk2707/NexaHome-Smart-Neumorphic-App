import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../devices/bloc/device_cubit.dart';
import '../bloc/room_cubit.dart';
import '../../../data/models/device_model.dart' as dm;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_toggle.dart';

class RoomDetailsScreen extends StatelessWidget {
  final String roomId;
  const RoomDetailsScreen({super.key, required this.roomId});

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
        title: Builder(
          builder: (context) {
            final rooms = context.read<RoomCubit>().state;
            final roomName = rooms.firstWhere((r) => r.id == roomId, orElse: () => rooms.first).name;
            return Text(roomName, style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface));
          }
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Devices in this room', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 16.h),

              BlocBuilder<DeviceCubit, List<dm.DeviceModel>>(
                builder: (context, devices) {
                  final roomDevices = devices.where((d) => d.roomId == roomId).toList();
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.w,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: roomDevices.length,
                    itemBuilder: (context, index) {
                      final device = roomDevices[index];
                      return _buildDeviceCard(context, device);
                    },
                  );
                }
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceCard(BuildContext context, dm.DeviceModel device) {
    return NeumorphicContainer(
      borderRadius: 24.r,
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              NeumorphicContainer(
                isPressed: device.isOn,
                borderRadius: 999,
                width: 48.w,
                height: 48.w,
                child: Icon(device.icon, color: device.isOn ? AppColors.primary : AppColors.lightTextSecondary),
              ),
              NeumorphicToggle(
                value: device.isOn,
                onChanged: (val) => context.read<DeviceCubit>().toggleDevice(device.id),
              ),
            ],
          ),
          Spacer(),
          Text(device.name, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface), maxLines: 1, overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
