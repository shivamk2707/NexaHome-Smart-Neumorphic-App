import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';
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
  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;
  String _statusText = 'Try saying: "Turn off all lights"';

  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    await _speechToText.initialize();
  }

  void _startListening() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      setState(() => _statusText = 'Microphone permission denied.');
      return;
    }

    await _speechToText.listen(onResult: (result) {
      setState(() {
        _statusText = result.recognizedWords;
      });
      if (result.finalResult) {
        _processCommand(result.recognizedWords.toLowerCase());
      }
    });

    setState(() {
      _isListening = true;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      _isListening = false;
    });
  }

  void _processCommand(String command) {
    if (mounted) {
      final devices = context.read<DeviceCubit>().state;
      if (command.contains('turn off') && command.contains('light')) {
        for (var device in devices) {
          if (device.type == dm.DeviceType.light && device.isOn) {
            context.read<DeviceCubit>().toggleDevice(device.id);
          }
        }
        setState(() {
          _statusText = 'Turned off all lights.';
        });
      } else if (command.contains('turn on') && command.contains('light')) {
        for (var device in devices) {
          if (device.type == dm.DeviceType.light && !device.isOn) {
            context.read<DeviceCubit>().toggleDevice(device.id);
          }
        }
        setState(() {
          _statusText = 'Turned on all lights.';
        });
      }
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
                onTap: _isListening ? _stopListening : _startListening,
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
