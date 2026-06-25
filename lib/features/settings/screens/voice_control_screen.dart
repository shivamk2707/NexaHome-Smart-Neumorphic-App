import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../devices/bloc/device_cubit.dart';
import '../../../data/models/device_model.dart' as dm;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_container.dart';
import '../../../core/widgets/neumorphic_button.dart';

class VoiceControlScreen extends StatefulWidget {
  const VoiceControlScreen({super.key});

  @override
  State<VoiceControlScreen> createState() => _VoiceControlScreenState();
}

class _VoiceControlScreenState extends State<VoiceControlScreen> {
  bool _isListening = false;
  String _statusText = 'Try saying: "Turn off all lights"';

  void _startListening() async {
    setState(() {
      _isListening = true;
      _statusText = 'Listening...';
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _statusText = 'Processing...';
    });

    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      final devices = context.read<DeviceCubit>().state;
      for (var device in devices) {
        if (device.type == dm.DeviceType.light && device.isOn) {
          context.read<DeviceCubit>().toggleDevice(device.id);
        }
      }
      setState(() {
        _isListening = false;
        _statusText = 'Turned off all lights.';
      });
    }
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
        title: Text('Voice Control', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 32.h),
              NeumorphicButton(
                onTap: _isListening ? () {} : _startListening,
                shape: BoxShape.circle,
                padding: EdgeInsets.all(48.w),
                child: Center(
                  child: Icon(
                    _isListening ? Icons.graphic_eq : Icons.mic,
                    size: 64.w,
                    color: _isListening ? AppColors.error : AppColors.primary
                  ),
                ),
              ),
              SizedBox(height: 48.h),
              Text(_isListening ? 'Listening...' : 'Voice Control Ready', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 16.h),
              Text(_statusText, style: AppTextStyles.bodyMedium(AppColors.lightTextSecondary)),
            ],
          ),
        ),
      ),
    );
  }
}
