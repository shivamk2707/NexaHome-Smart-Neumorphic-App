import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_toggle.dart';

class SecuritySettingsScreen extends StatefulWidget {
  const SecuritySettingsScreen({super.key});

  @override
  State<SecuritySettingsScreen> createState() => _SecuritySettingsScreenState();
}

class _SecuritySettingsScreenState extends State<SecuritySettingsScreen> {
  bool _twoFactor = true;
  bool _biometric = false;

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
        title: Text('Security', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NeumorphicContainer(
                borderRadius: 24.r,
                padding: EdgeInsets.all(20.w),
                child: Column(
                  children: [
                    _buildToggleRow(context, 'Two-Factor Authentication', Icons.security, _twoFactor, (val) => setState(() => _twoFactor = val)),
                    SizedBox(height: 16.h),
                    _buildToggleRow(context, 'Biometric Login', Icons.fingerprint, _biometric, (val) => setState(() => _biometric = val)),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              Text('Change Password', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 16.h),
              NeumorphicContainer(
                isPressed: true,
                borderRadius: 16.r,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Current Password',
                    hintStyle: AppTextStyles.bodyMedium(AppColors.lightTextSecondary),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              NeumorphicContainer(
                isPressed: true,
                borderRadius: 16.r,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'New Password',
                    hintStyle: AppTextStyles.bodyMedium(AppColors.lightTextSecondary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToggleRow(BuildContext context, String title, IconData icon, bool value, ValueChanged<bool> onChanged) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary),
        SizedBox(width: 16.w),
        Expanded(child: Text(title, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface))),
        NeumorphicToggle(value: value, onChanged: onChanged),
      ],
    );
  }
}
