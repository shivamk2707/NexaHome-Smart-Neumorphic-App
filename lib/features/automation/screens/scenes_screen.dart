import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/scene_cubit.dart';
import '../../../data/models/scene_model.dart';
import '../../devices/bloc/device_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';

class ScenesScreen extends StatelessWidget {
  const ScenesScreen({super.key});

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
        title: Text('Scenes', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Theme.of(context).colorScheme.onSurface),
            onPressed: () => context.push('/create_new_scene'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: BlocBuilder<SceneCubit, List<SceneModel>>(
            builder: (context, scenes) {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: scenes.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16.w,
                  mainAxisSpacing: 16.w,
                  childAspectRatio: 1.0,
                ),
                itemBuilder: (context, index) {
                  final scene = scenes[index];
                  return NeumorphicButton(
                    onTap: () {
                      context.push('/automation_detail/${scene.id}');
                    },
                    borderRadius: 24.r,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(scene.icon, size: 48.w, color: AppColors.primary),
                        SizedBox(height: 16.h),
                        Text(
                          scene.name,
                          style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          ),
        ),
      ),
    );
  }
}
