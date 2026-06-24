import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_container.dart';

class DevicePairingScreen extends StatefulWidget {
  const DevicePairingScreen({super.key});

  @override
  State<DevicePairingScreen> createState() => _DevicePairingScreenState();
}

class _DevicePairingScreenState extends State<DevicePairingScreen> {
  @override
  void initState() {
    super.initState();
    _simulatePairing();
  }

  void _simulatePairing() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.push('/device_setup_form');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Theme.of(context).colorScheme.onSurface),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Pairing Device', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 280.w,
                    height: 280.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.2), width: 2),
                    ),
                  ).animate(onPlay: (controller) => controller.repeat())
                   .scale(begin: const Offset(0.5, 0.5), end: const Offset(1.5, 1.5), duration: const Duration(seconds: 2))
                   .fade(begin: 1.0, end: 0.0, duration: const Duration(seconds: 2)),

                  NeumorphicContainer(
                    shape: BoxShape.circle,
                    width: 120.w,
                    height: 120.w,
                    padding: EdgeInsets.all(24.w),
                    child: Center(
                      child: Icon(Icons.bluetooth_searching, size: 48.w, color: AppColors.primary),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48.h),
              Text('Looking for devices...', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 16.h),
              Text('Make sure your device is turned on and in pairing mode.',
                   style: AppTextStyles.bodyMedium(AppColors.lightTextSecondary),
                   textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
