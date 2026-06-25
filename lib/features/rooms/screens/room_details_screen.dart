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

import 'dart:math';
import '../../../core/widgets/neumorphic_button.dart';

class RoomDetailsScreen extends StatefulWidget {
  final String roomId;
  const RoomDetailsScreen({super.key, required this.roomId});

  @override
  State<RoomDetailsScreen> createState() => _RoomDetailsScreenState();
}

class _RoomDetailsScreenState extends State<RoomDetailsScreen> {
  void _showAddDeviceSheet(BuildContext context) {
    final nameController = TextEditingController();
    dm.DeviceType selectedType = dm.DeviceType.light;
    IconData selectedIcon = Icons.lightbulb_outline;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
            return Container(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
                left: 24.w,
                right: 24.w,
                top: 24.h,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add New Device', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
                  SizedBox(height: 24.h),
                  Text('Device Name', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                  SizedBox(height: 8.h),
                  NeumorphicContainer(
                    isPressed: true,
                    borderRadius: 16.r,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: TextField(
                      controller: nameController,
                      decoration: const InputDecoration(border: InputBorder.none, hintText: 'e.g. Desk Lamp'),
                      style: AppTextStyles.bodyMedium(Theme.of(context).colorScheme.onSurface),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text('Device Type', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                  SizedBox(height: 8.h),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildTypeSelector(context, 'Light', Icons.lightbulb_outline, dm.DeviceType.light, selectedType, (t, i) => setSheetState(() { selectedType = t; selectedIcon = i; })),
                        _buildTypeSelector(context, 'AC', Icons.ac_unit, dm.DeviceType.ac, selectedType, (t, i) => setSheetState(() { selectedType = t; selectedIcon = i; })),
                        _buildTypeSelector(context, 'Fan', Icons.air, dm.DeviceType.fan, selectedType, (t, i) => setSheetState(() { selectedType = t; selectedIcon = i; })),
                        _buildTypeSelector(context, 'Lock', Icons.lock, dm.DeviceType.lock, selectedType, (t, i) => setSheetState(() { selectedType = t; selectedIcon = i; })),
                      ],
                    ),
                  ),
                  SizedBox(height: 32.h),
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: NeumorphicButton(
                      onTap: () {
                        if (nameController.text.isNotEmpty) {
                          final newDevice = dm.DeviceModel(
                            id: 'd_${DateTime.now().millisecondsSinceEpoch}',
                            name: nameController.text,
                            roomId: widget.roomId,
                            type: selectedType,
                            icon: selectedIcon,
                          );
                          context.read<DeviceCubit>().addDevice(newDevice);
                          Navigator.pop(context);
                        }
                      },
                      borderRadius: 16.r,
                      child: Center(
                        child: Text('Add Device', style: AppTextStyles.labelMedium(AppColors.primary)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        );
      },
    );
  }

  Widget _buildTypeSelector(BuildContext context, String label, IconData icon, dm.DeviceType type, dm.DeviceType selectedType, Function(dm.DeviceType, IconData) onTap) {
    final isSelected = selectedType == type;
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: GestureDetector(
        onTap: () => onTap(type, icon),
        child: Column(
          children: [
            NeumorphicContainer(
              isPressed: isSelected,
              shape: BoxShape.circle,
              padding: EdgeInsets.all(16.w),
              child: Icon(icon, color: isSelected ? AppColors.primary : AppColors.lightTextSecondary),
            ),
            SizedBox(height: 8.h),
            Text(label, style: AppTextStyles.labelSmall(isSelected ? AppColors.primary : AppColors.lightTextSecondary)),
          ],
        ),
      ),
    );
  }

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
            final roomName = rooms.firstWhere((r) => r.id == widget.roomId, orElse: () => rooms.first).name;
            return Text(roomName, style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface));
          }
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => _showAddDeviceSheet(context),
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
              Text('Devices in this room', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 16.h),

              BlocBuilder<DeviceCubit, List<dm.DeviceModel>>(
                builder: (context, devices) {
                  final roomDevices = devices.where((d) => d.roomId == widget.roomId).toList();
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
