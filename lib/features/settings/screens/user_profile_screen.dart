import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../auth/bloc/auth_cubit.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

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
        title: Text('Profile', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              SizedBox(height: 32.h),
              NeumorphicContainer(
                shape: BoxShape.circle,
                width: 120.w,
                height: 120.w,
                padding: EdgeInsets.all(8.w),
                child: NeumorphicContainer(
                  isPressed: true,
                  shape: BoxShape.circle,
                  child: Center(
                    child: Icon(Icons.person, size: 64.w, color: AppColors.primary),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) => Text(state.userName ?? 'User', style: AppTextStyles.headlineLarge(Theme.of(context).colorScheme.onSurface)),
              ),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) => Text(state.userEmail ?? '', style: AppTextStyles.bodyMedium(AppColors.lightTextSecondary)),
              ),
              SizedBox(height: 48.h),

              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) => _buildTextField(context, 'Full Name', state.userName ?? '', Icons.person_outline),
              ),
              SizedBox(height: 24.h),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) => _buildTextField(context, 'Email Address', state.userEmail ?? '', Icons.email_outlined),
              ),
              SizedBox(height: 24.h),
              _buildTextField(context, 'Phone Number', '+1 234 567 8900', Icons.phone_outlined),

              SizedBox(height: 24.h),
              _buildActionRow(context, 'Activity History', Icons.history, () => context.push('/activity_history')),
              SizedBox(height: 16.h),
              _buildActionRow(context, 'Favorites', Icons.favorite_border, () => context.push('/favorites')),
              SizedBox(height: 16.h),
              _buildActionRow(context, 'Voice Control', Icons.mic_none, () => context.push('/voice_control')),
              SizedBox(height: 16.h),
              _buildActionRow(context, 'AI Smart Assistant', Icons.smart_toy_outlined, () => context.push('/ai_smart_assistant')),
              SizedBox(height: 16.h),
              _buildActionRow(context, 'Home Members', Icons.group_outlined, () => context.push('/home_members')),
              SizedBox(height: 16.h),
              _buildActionRow(context, 'Subscription Plan', Icons.card_membership, () => context.push('/subscription_plan')),
              SizedBox(height: 16.h),
              _buildActionRow(context, 'Help & Support', Icons.help_outline, () => context.push('/help_support')),

              SizedBox(height: 48.h),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: NeumorphicButton(
                  onTap: () {},
                  borderRadius: 16.r,
                  child: Center(
                    child: Text('Save Changes', style: AppTextStyles.labelMedium(AppColors.primary)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(BuildContext context, String label, String initialValue, IconData icon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
        SizedBox(height: 8.h),
        NeumorphicContainer(
          isPressed: true,
          borderRadius: 16.r,
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
              border: InputBorder.none,
              icon: Icon(icon, color: AppColors.primary),
            ),
            style: AppTextStyles.bodyMedium(Theme.of(context).colorScheme.onSurface),
          ),
        ),
      ],
    );
  }

  Widget _buildActionRow(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: NeumorphicContainer(
        borderRadius: 16.r,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary),
            SizedBox(width: 16.w),
            Expanded(child: Text(title, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface))),
            Icon(Icons.chevron_right, color: AppColors.lightTextSecondary),
          ],
        ),
      ),
    );
  }
}
