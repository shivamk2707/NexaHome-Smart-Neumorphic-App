import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_toggle.dart';
import '../bloc/scene_cubit.dart';
import '../../devices/bloc/device_cubit.dart';
import '../../../data/models/scene_model.dart';

class AutomationDetailScreen extends StatefulWidget {
  final String sceneId;
  const AutomationDetailScreen({super.key, required this.sceneId});

  @override
  State<AutomationDetailScreen> createState() => _AutomationDetailScreenState();
}

class _AutomationDetailScreenState extends State<AutomationDetailScreen> {
  bool _isActive = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SceneCubit, List<SceneModel>>(
      builder: (context, scenes) {
        final scene = scenes.firstWhere((s) => s.id == widget.sceneId, orElse: () => scenes.first);

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurface),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text('Routine Details', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
            actions: [
              NeumorphicToggle(
                value: _isActive,
                onChanged: (val) => setState(() => _isActive = val),
              ),
              SizedBox(width: 24.w),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(scene.icon, color: AppColors.primary, size: 32.w),
                      SizedBox(width: 16.w),
                      Expanded(child: Text(scene.name, style: AppTextStyles.headlineLarge(Theme.of(context).colorScheme.onSurface))),
                    ],
                  ),
                  SizedBox(height: 32.h),

                  Text('When', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                  SizedBox(height: 8.h),
                  NeumorphicContainer(
                    borderRadius: 16.r,
                    padding: EdgeInsets.all(16.w),
                    child: Row(
                      children: [
                        Icon(Icons.touch_app, color: AppColors.primary),
                        SizedBox(width: 16.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Manual Trigger', style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface)),
                            Text('Tap to execute', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 32.h),
                  Text('Do', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                  SizedBox(height: 8.h),

                  if (scene.actions.isEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: Text('No actions configured.', style: AppTextStyles.bodyMedium(AppColors.lightTextSecondary)),
                    ),

                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: scene.actions.length,
                    separatorBuilder: (_, __) => SizedBox(height: 16.h),
                    itemBuilder: (context, index) {
                      final action = scene.actions[index];
                      // Attempt to resolve the real device icon if possible, otherwise generic
                      IconData icon = Icons.devices;
                      final devices = context.read<DeviceCubit>().state;
                      try {
                        icon = devices.firstWhere((d) => d.id == action.deviceId).icon;
                      } catch (e) {
                        // ignore
                      }

                      return _buildActionItem(
                        context,
                        action.deviceName,
                        action.targetIsOn ? 'Turn On' : 'Turn Off',
                        icon
                      );
                    },
                  ),

                  SizedBox(height: 48.h),
                  SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: NeumorphicButton(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
                              title: Text('Confirm Execution', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
                              content: Text('Are you sure you want to execute ${scene.name}?', style: AppTextStyles.bodyMedium(AppColors.lightTextSecondary)),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(dialogContext).pop(),
                                  child: Text('Cancel', style: AppTextStyles.labelMedium(AppColors.lightTextSecondary)),
                                ),
                                NeumorphicButton(
                                  onTap: () {
                                    context.read<SceneCubit>().executeScene(scene.id, context.read<DeviceCubit>());
                                    Navigator.of(dialogContext).pop(); // Close dialog
                                    Navigator.of(context).pop(); // Go back to previous screen
                                  },
                                  borderRadius: 16.r,
                                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                                  child: Text('Confirm', style: AppTextStyles.labelMedium(AppColors.primary)),
                                ),
                              ],
                            );
                          }
                        );
                      },
                      borderRadius: 16.r,
                      child: Center(
                        child: Text('Execute Now', style: AppTextStyles.labelMedium(AppColors.primary)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    );
  }

  Widget _buildActionItem(BuildContext context, String device, String action, IconData icon) {
    return NeumorphicContainer(
      borderRadius: 16.r,
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(device, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface)),
                Text(action, style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
