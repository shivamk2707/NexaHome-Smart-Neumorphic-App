import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_toggle.dart';

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
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
                      Text(
                        'Alex',
                        style: AppTextStyles.headlineLarge(Theme.of(context).colorScheme.onSurface),
                      ),
                    ],
                  ),
                  NeumorphicButton(
                    onTap: () {},
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

              // Room Tabs (Placeholder list)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    _buildRoomTab(context, 'Living Room', true),
                    SizedBox(width: 16.w),
                    _buildRoomTab(context, 'Bedroom', false),
                    SizedBox(width: 16.w),
                    _buildRoomTab(context, 'Kitchen', false),
                  ],
                ),
              ),
              SizedBox(height: 32.h),

              // Devices Grid
              Text(
                'Active Devices',
                style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface),
              ),
              SizedBox(height: 16.h),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.w,
                childAspectRatio: 0.85,
                children: [
                  _buildDeviceCard(context, 'Smart AC', 'Living Room', Icons.ac_unit, true, onTap: () => context.push('/ac_control')),
                  _buildDeviceCard(context, 'Main Light', 'Living Room', Icons.lightbulb_outline, false, onTap: () => context.push('/light_control')),
                  _buildDeviceCard(context, 'Smart Door', 'Front', Icons.lock, true, onTap: () => context.push('/lock_control')),
                  _buildDeviceCard(context, 'Ceiling Fan', 'Living Room', Icons.air, false, onTap: () => context.push('/fan_control')),
                ],
              ),
            ],
          ),
        ),
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

  Widget _buildDeviceCard(BuildContext context, String name, String room, IconData icon, bool isOn, {VoidCallback? onTap}) {
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
                  isPressed: isOn,
                  borderRadius: 999,
                  width: 48.w,
                  height: 48.w,
                  child: Icon(icon, color: isOn ? AppColors.primary : AppColors.lightTextSecondary),
                ),
                StatefulBuilder(builder: (context, setState) {
                  return NeumorphicToggle(
                    value: isOn,
                    onChanged: (val) {
                      setState(() => isOn = val);
                    },
                  );
                }),
              ],
            ),
            Spacer(),
            Text(name, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface), maxLines: 1, overflow: TextOverflow.ellipsis),
            SizedBox(height: 4.h),
            Text(room, style: AppTextStyles.labelSmall(AppColors.lightTextSecondary), maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
