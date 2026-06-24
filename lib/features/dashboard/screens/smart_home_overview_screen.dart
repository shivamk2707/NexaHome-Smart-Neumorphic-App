import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../rooms/bloc/room_cubit.dart';
import '../../devices/bloc/device_cubit.dart';
import '../../../data/models/room_model.dart';
import '../../../data/models/device_model.dart' as dm;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_button.dart';

class SmartHomeOverviewScreen extends StatelessWidget {
  const SmartHomeOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('My Home', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Stats
              BlocBuilder<DeviceCubit, List<dm.DeviceModel>>(
                builder: (context, devices) {
                  final activeCount = devices.where((d) => d.isOn).length;
                  return Row(
                    children: [
                      Expanded(
                        child: _buildStatCard(context, 'Devices On', '$activeCount', Icons.devices),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: _buildStatCard(context, 'Power Usage', '3.2 kW', Icons.electric_bolt),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: 32.h),

              Text(
                'Rooms',
                style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface),
              ),
              SizedBox(height: 16.h),

              BlocBuilder<RoomCubit, List<RoomModel>>(
                builder: (context, rooms) {
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: rooms.length,
                    separatorBuilder: (context, index) => SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      final room = rooms[index];
                      // Calculate devices per room
                      final devicesInRoom = context.read<DeviceCubit>().state.where((d) => d.roomId == room.id).length;

                      return NeumorphicButton(
                        onTap: () {},
                        borderRadius: 24.r,
                        padding: EdgeInsets.all(20.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(room.name, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface)),
                                SizedBox(height: 4.h),
                                Text('$devicesInRoom Devices', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                              ],
                            ),
                            Icon(Icons.chevron_right, color: AppColors.lightTextSecondary),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String title, String value, IconData icon) {
    return NeumorphicContainer(
      borderRadius: 24.r,
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.primary),
          SizedBox(height: 16.h),
          Text(value, style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
          SizedBox(height: 4.h),
          Text(title, style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
        ],
      ),
    );
  }
}
