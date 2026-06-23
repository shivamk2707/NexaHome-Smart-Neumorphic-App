import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_toggle.dart';

class AutomationDashboardScreen extends StatelessWidget {
  const AutomationDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Automations', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
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
              Text('Routines', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 16.h),
              _buildAutomationCard(context, 'Good Morning', 'Turns on lights, opens blinds', Icons.wb_sunny, true),
              SizedBox(height: 16.h),
              _buildAutomationCard(context, 'Leaving Home', 'Turns off all devices, locks door', Icons.directions_walk, false),
              SizedBox(height: 16.h),
              _buildAutomationCard(context, 'Good Night', 'Dims lights, sets AC to 24°C', Icons.nights_stay, true),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAutomationCard(BuildContext context, String title, String subtitle, IconData icon, bool isActive) {
    return NeumorphicContainer(
      borderRadius: 24.r,
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          NeumorphicContainer(
            isPressed: true,
            borderRadius: 16.r,
            padding: EdgeInsets.all(12.w),
            child: Icon(icon, color: AppColors.primary),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface)),
                SizedBox(height: 4.h),
                Text(subtitle, style: AppTextStyles.labelSmall(AppColors.lightTextSecondary), maxLines: 2, overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          StatefulBuilder(builder: (context, setState) {
            return NeumorphicToggle(
              value: isActive,
              onChanged: (val) {
                setState(() => isActive = val);
              },
            );
          }),
        ],
      ),
    );
  }
}
