import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_toggle.dart';
import '../bloc/scene_cubit.dart';
import '../../devices/bloc/device_cubit.dart';
import '../../../data/models/scene_model.dart';
import '../../../data/models/device_model.dart' as dm;

class CreateNewSceneScreen extends StatefulWidget {
  const CreateNewSceneScreen({super.key});

  @override
  State<CreateNewSceneScreen> createState() => _CreateNewSceneScreenState();
}

class _CreateNewSceneScreenState extends State<CreateNewSceneScreen> {
  final _nameController = TextEditingController();
  IconData _selectedIcon = Icons.movie;
  final List<SceneAction> _actions = [];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _showAddActionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(sheetContext).viewInsets.bottom + 24.h,
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
              Text('Select Device', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 16.h),
              BlocBuilder<DeviceCubit, List<dm.DeviceModel>>(
                builder: (context, devices) {
                  return ListView.separated(
                    shrinkWrap: true,
                    itemCount: devices.length,
                    separatorBuilder: (_, __) => SizedBox(height: 8.h),
                    itemBuilder: (context, index) {
                      final device = devices[index];
                      return NeumorphicButton(
                        onTap: () {
                          setState(() {
                            // default action is to turn it ON
                            _actions.add(SceneAction(
                              deviceId: device.id,
                              deviceName: device.name,
                              targetIsOn: true,
                            ));
                          });
                          Navigator.pop(sheetContext);
                        },
                        borderRadius: 16.r,
                        padding: EdgeInsets.all(16.w),
                        child: Row(
                          children: [
                            Icon(device.icon, color: AppColors.primary),
                            SizedBox(width: 16.w),
                            Text(device.name, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface)),
                          ],
                        ),
                      );
                    },
                  );
                }
              ),
            ],
          ),
        );
      },
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
        title: Text('New Scene', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Scene Name', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
              SizedBox(height: 8.h),
              NeumorphicContainer(
                isPressed: true,
                borderRadius: 16.r,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'e.g. Movie Time',
                    hintStyle: AppTextStyles.bodyMedium(AppColors.lightTextSecondary),
                  ),
                  style: AppTextStyles.bodyMedium(Theme.of(context).colorScheme.onSurface),
                ),
              ),

              SizedBox(height: 32.h),
              Text('Icon', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
              SizedBox(height: 8.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                child: Row(
                  children: [
                    _buildIconSelector(context, Icons.movie, _selectedIcon == Icons.movie),
                    _buildIconSelector(context, Icons.restaurant, _selectedIcon == Icons.restaurant),
                    _buildIconSelector(context, Icons.celebration, _selectedIcon == Icons.celebration),
                    _buildIconSelector(context, Icons.wb_sunny, _selectedIcon == Icons.wb_sunny),
                    _buildIconSelector(context, Icons.nights_stay, _selectedIcon == Icons.nights_stay),
                  ],
                ),
              ),

              SizedBox(height: 32.h),
              Text('Actions', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
              SizedBox(height: 8.h),

              if (_actions.isNotEmpty)
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _actions.length,
                  separatorBuilder: (_, __) => SizedBox(height: 8.h),
                  itemBuilder: (context, index) {
                    final action = _actions[index];
                    return NeumorphicContainer(
                      borderRadius: 16.r,
                      padding: EdgeInsets.all(16.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(action.deviceName, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface)),
                          ),
                          Text(action.targetIsOn ? 'Turn ON' : 'Turn OFF', style: AppTextStyles.labelSmall(AppColors.lightTextSecondary)),
                          SizedBox(width: 8.w),
                          NeumorphicToggle(
                            value: action.targetIsOn,
                            onChanged: (val) {
                              setState(() {
                                _actions[index] = SceneAction(
                                  deviceId: action.deviceId,
                                  deviceName: action.deviceName,
                                  targetIsOn: val,
                                );
                              });
                            }
                          ),
                        ],
                      ),
                    );
                  }
                ),
              if (_actions.isNotEmpty) SizedBox(height: 16.h),

              NeumorphicButton(
                onTap: () => _showAddActionSheet(context),
                borderRadius: 16.r,
                padding: EdgeInsets.all(16.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: AppColors.primary),
                    SizedBox(width: 8.w),
                    Text('Add Action', style: AppTextStyles.labelMedium(AppColors.primary)),
                  ],
                ),
              ),

              SizedBox(height: 48.h),
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: NeumorphicButton(
                  onTap: () {
                    if (_nameController.text.isNotEmpty) {
                      final newScene = SceneModel(
                        id: 's_${DateTime.now().millisecondsSinceEpoch}',
                        name: _nameController.text,
                        icon: _selectedIcon,
                        actions: _actions,
                      );
                      context.read<SceneCubit>().addScene(newScene);
                      context.pop();
                    }
                  },
                  borderRadius: 16.r,
                  child: Center(
                    child: Text('Save Scene', style: AppTextStyles.labelMedium(AppColors.primary)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIconSelector(BuildContext context, IconData icon, bool isSelected) {
    return Padding(
      padding: EdgeInsets.only(right: 16.w),
      child: NeumorphicButton(
        onTap: () => setState(() => _selectedIcon = icon),
        shape: BoxShape.circle,
        padding: EdgeInsets.all(16.w),
        child: Icon(icon, color: isSelected ? AppColors.primary : AppColors.lightTextSecondary),
      ),
    );
  }
}
