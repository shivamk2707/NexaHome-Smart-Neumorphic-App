import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../bloc/device_cubit.dart';
import '../../rooms/bloc/room_cubit.dart';
import '../../../data/models/device_model.dart' as dm;
import '../../../data/models/room_model.dart';
import 'dart:math';

class DeviceSetupFormScreen extends StatefulWidget {
  const DeviceSetupFormScreen({super.key});

  @override
  State<DeviceSetupFormScreen> createState() => _DeviceSetupFormScreenState();
}

class _DeviceSetupFormScreenState extends State<DeviceSetupFormScreen> {
  final _nameController = TextEditingController(text: 'Smart Bulb 1');
  String? _selectedRoomId;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
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
        title: Text('Setup Device', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: NeumorphicContainer(
                  shape: BoxShape.circle,
                  width: 120.w,
                  height: 120.w,
                  padding: EdgeInsets.all(24.w),
                  child: Center(
                    child: Icon(Icons.lightbulb_outline, size: 64.w, color: AppColors.primary),
                  ),
                ),
              ),
              SizedBox(height: 32.h),

              Text('Device Name', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
              SizedBox(height: 8.h),
              NeumorphicContainer(
                isPressed: true,
                borderRadius: 16.r,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(border: InputBorder.none),
                  style: AppTextStyles.bodyMedium(Theme.of(context).colorScheme.onSurface),
                ),
              ),

              SizedBox(height: 24.h),
              Text('Room', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
              SizedBox(height: 8.h),

              BlocBuilder<RoomCubit, List<RoomModel>>(
                builder: (context, rooms) {
                  return NeumorphicContainer(
                    isPressed: true,
                    borderRadius: 16.r,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedRoomId ?? (rooms.isNotEmpty ? rooms.first.id : null),
                        isExpanded: true,
                        dropdownColor: Theme.of(context).colorScheme.surface,
                        items: rooms.map((room) {
                          return DropdownMenuItem(
                            value: room.id,
                            child: Text(room.name, style: AppTextStyles.bodyMedium(Theme.of(context).colorScheme.onSurface)),
                          );
                        }).toList(),
                        onChanged: (val) {
                          setState(() => _selectedRoomId = val);
                        },
                      ),
                    ),
                  );
                }
              ),

              SizedBox(height: 48.h),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: NeumorphicButton(
                  onTap: () {
                    final rooms = context.read<RoomCubit>().state;
                    final roomId = _selectedRoomId ?? (rooms.isNotEmpty ? rooms.first.id : 'r1');

                    final newDevice = dm.DeviceModel(
                      id: 'd_${Random().nextInt(10000)}',
                      name: _nameController.text,
                      roomId: roomId,
                      type: dm.DeviceType.light,
                      icon: Icons.lightbulb_outline,
                      isOn: false,
                    );
                    context.read<DeviceCubit>().addDevice(newDevice);
                    context.go('/dashboard');
                  },
                  borderRadius: 16.r,
                  child: Center(
                    child: Text('Complete Setup', style: AppTextStyles.labelMedium(AppColors.primary)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
