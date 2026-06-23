import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_toggle.dart';

class RoomDetailsScreen extends StatelessWidget {
  const RoomDetailsScreen({super.key});

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
        title: Text('Living Room', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
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

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.w,
                childAspectRatio: 0.85,
                children: [
                  _buildDeviceCard(context, 'Smart AC', Icons.ac_unit, true),
                  _buildDeviceCard(context, 'Main Light', Icons.lightbulb_outline, false),
                  _buildDeviceCard(context, 'Smart TV', Icons.tv, true),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceCard(BuildContext context, String name, IconData icon, bool isOn) {
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
        ],
      ),
    );
  }
}
