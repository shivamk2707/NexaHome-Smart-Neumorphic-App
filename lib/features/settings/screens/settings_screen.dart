import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_toggle.dart';
import '../../../core/theme/theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Settings', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSection(context, 'Preferences', [
                _buildToggleRow(
                  context,
                  'Dark Mode',
                  Icons.dark_mode_outlined,
                  context.watch<ThemeCubit>().state == ThemeMode.dark,
                  (val) => context.read<ThemeCubit>().toggleTheme(),
                ),
                SizedBox(height: 16.h),
                _buildToggleRow(context, 'Notifications', Icons.notifications_none, true, (val) {}),
              ]),
              SizedBox(height: 32.h),
              _buildSection(context, 'Account', [
                _buildActionRow(context, 'Profile Information', Icons.person_outline, () => context.push('/user_profile')),
                SizedBox(height: 16.h),
                _buildActionRow(context, 'Security', Icons.security, () {}),
              ]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(BuildContext context, String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
        SizedBox(height: 16.h),
        NeumorphicContainer(
          borderRadius: 24.r,
          padding: EdgeInsets.all(20.w),
          child: Column(children: children),
        ),
      ],
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

  Widget _buildActionRow(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          SizedBox(width: 16.w),
          Expanded(child: Text(title, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface))),
          Icon(Icons.chevron_right, color: AppColors.lightTextSecondary),
        ],
      ),
    );
  }
}
