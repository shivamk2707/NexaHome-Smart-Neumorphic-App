import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';

class AddNewDeviceScreen extends StatelessWidget {
  const AddNewDeviceScreen({super.key});

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
        title: Text('Add Device', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Device Type', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 16.h),

              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 16.w,
                mainAxisSpacing: 16.w,
                childAspectRatio: 1.0,
                children: [
                  _buildDeviceCategory(context, 'Lighting', Icons.lightbulb_outline),
                  _buildDeviceCategory(context, 'Climate', Icons.ac_unit),
                  _buildDeviceCategory(context, 'Security', Icons.security),
                  _buildDeviceCategory(context, 'Appliances', Icons.tv),
                ],
              ),

              SizedBox(height: 32.h),
              Center(
                child: TextButton.icon(
                  onPressed: () => context.push('/device_pairing'),
                  icon: Icon(Icons.bluetooth_searching, color: AppColors.primary),
                  label: Text('Scan for nearby devices', style: AppTextStyles.labelMedium(AppColors.primary)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeviceCategory(BuildContext context, String title, IconData icon) {
    return NeumorphicButton(
      onTap: () => context.push('/device_pairing'),
      borderRadius: 24.r,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48.w, color: AppColors.primary),
          SizedBox(height: 16.h),
          Text(title, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface)),
        ],
      ),
    );
  }
}
