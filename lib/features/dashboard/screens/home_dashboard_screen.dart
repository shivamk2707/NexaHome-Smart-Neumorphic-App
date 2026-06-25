import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/bloc/auth_cubit.dart';
import '../../devices/bloc/device_cubit.dart';
import '../../rooms/bloc/room_cubit.dart';
import '../../../data/models/device_model.dart' as dm;
import '../../../data/models/room_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_toggle.dart';

class HomeDashboardScreen extends StatefulWidget {
  const HomeDashboardScreen({super.key});

  @override
  State<HomeDashboardScreen> createState() => _HomeDashboardScreenState();
}

class _HomeDashboardScreenState extends State<HomeDashboardScreen> {
  String? _selectedRoomId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add_device'),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good Morning,',
                        style: AppTextStyles.bodyMedium(AppColors.lightTextSecondary),
                      ),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          return Text(
                            state.userName?.split(' ').first ?? 'User',
                            style: AppTextStyles.headlineLarge(Theme.of(context).colorScheme.onSurface),
                          );
                        }
                      ),
                    ],
                  ),
                  NeumorphicButton(
                    onTap: () => context.push('/user_profile'),
                    borderRadius: 999,
                    child: CircleAvatar(
                      radius: 24.w,
                      backgroundColor: Colors.transparent,
                      child: Icon(Icons.person, color: AppColors.primary),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),

              // Weather / Quick Info Widget
              GestureDetector(
                onTap: () => context.push('/energy'),
                child: NeumorphicContainer(
                  borderRadius: 24.r,
                  padding: EdgeInsets.all(20.w),
                  child: Row(
                    children: [
                      Icon(Icons.wb_sunny, color: Colors.amber, size: 48.w),
                      SizedBox(width: 16.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('24°C', style: AppTextStyles.headlineLarge(Theme.of(context).colorScheme.onSurface)),
                          Text('Sunny • Outdoor', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 32.h),
              Text('Quick Scenes', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 16.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    _buildSceneButton(context, 'Movie Time', Icons.movie),
                    SizedBox(width: 16.w),
                    _buildSceneButton(context, 'Focus', Icons.center_focus_strong),
                    SizedBox(width: 16.w),
                    _buildSceneButton(context, 'Good Night', Icons.nights_stay),
                    SizedBox(width: 16.w),
                    _buildSceneButton(context, 'Leaving Home', Icons.directions_walk),
                  ],
                ),
              ),

              SizedBox(height: 32.h),

              // Room Tabs (Dynamic)
              BlocBuilder<RoomCubit, List<RoomModel>>(
                builder: (context, rooms) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 16.w),
                          child: GestureDetector(
                            onTap: () => setState(() => _selectedRoomId = null),
                            child: _buildRoomTab(context, 'All', _selectedRoomId == null),
                          ),
                        ),
                        ...rooms.map((room) {
                          return Padding(
                            padding: EdgeInsets.only(right: 16.w),
                            child: GestureDetector(
                              onTap: () => setState(() => _selectedRoomId = room.id),
                              child: _buildRoomTab(context, room.name, _selectedRoomId == room.id),
                            ),
                          );
                        }),
                      ],
                    ),
                  );
                },
              ),
              SizedBox(height: 32.h),

              // Devices Grid
              Text(
                'Active Devices',
                style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface),
              ),
              SizedBox(height: 16.h),
              BlocBuilder<DeviceCubit, List<dm.DeviceModel>>(
                builder: (context, devices) {
                  final filteredDevices = _selectedRoomId == null
                      ? devices
                      : devices.where((d) => d.roomId == _selectedRoomId).toList();
                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16.w,
                      mainAxisSpacing: 16.w,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: filteredDevices.length,
                    itemBuilder: (context, index) {
                      final device = filteredDevices[index];
                      // Find room name
                      final rooms = context.read<RoomCubit>().state;
                      final roomName = rooms.firstWhere((r) => r.id == device.roomId, orElse: () => const RoomModel(id: '', name: 'Unknown', icon: Icons.error)).name;

                      return _buildDeviceCard(
                        context,
                        device,
                        roomName,
                        onTap: () {
                          if (device.type == dm.DeviceType.ac) context.push('/ac_control/${device.id}');
                          if (device.type == dm.DeviceType.light) context.push('/light_control/${device.id}');
                          if (device.type == dm.DeviceType.lock) context.push('/lock_control/${device.id}');
                          if (device.type == dm.DeviceType.fan) context.push('/fan_control/${device.id}');
                        },
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

  Widget _buildSceneButton(BuildContext context, String name, IconData icon) {
    return NeumorphicButton(
      onTap: () {},
      borderRadius: 16.r,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppColors.primary, size: 20.w),
          SizedBox(width: 8.w),
          Text(name, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    );
  }

  Widget _buildRoomTab(BuildContext context, String name, bool isActive) {
    return NeumorphicContainer(
      isPressed: isActive,
      borderRadius: 999,
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
      child: Text(
        name,
        style: AppTextStyles.labelMedium(isActive ? AppColors.primary : AppColors.lightTextSecondary),
      ),
    );
  }

  Widget _buildDeviceCard(BuildContext context, dm.DeviceModel device, String roomName, {VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: NeumorphicContainer(
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
                  onChanged: (val) {
                    context.read<DeviceCubit>().toggleDevice(device.id);
                  },
                ),
              ],
            ),
            const Spacer(),
            Text(device.name, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface), maxLines: 1, overflow: TextOverflow.ellipsis),
            SizedBox(height: 4.h),
            Text(roomName, style: AppTextStyles.labelSmall(AppColors.lightTextSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
