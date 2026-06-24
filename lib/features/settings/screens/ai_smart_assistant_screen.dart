import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_container.dart';

class AiSmartAssistantScreen extends StatelessWidget {
  const AiSmartAssistantScreen({super.key});

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
        title: Text('Nexa AI', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: EdgeInsets.all(24.w),
                children: [
                  _buildMessage(context, 'Hello! How can I help you manage your home today?', false),
                  SizedBox(height: 16.h),
                  _buildMessage(context, 'Turn on the living room AC.', true),
                  SizedBox(height: 16.h),
                  _buildMessage(context, 'Living room AC has been turned on and set to 24 degrees.', false),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: NeumorphicContainer(
                isPressed: true,
                borderRadius: 24.r,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type your message...',
                          hintStyle: AppTextStyles.bodyMedium(AppColors.lightTextSecondary),
                        ),
                      ),
                    ),
                    Icon(Icons.send, color: AppColors.primary),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessage(BuildContext context, String text, bool isUser) {
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: NeumorphicContainer(
        borderRadius: 16.r,
        padding: EdgeInsets.all(16.w),
        child: Text(
          text,
          style: AppTextStyles.bodyMedium(isUser ? AppColors.primary : Theme.of(context).colorScheme.onSurface),
        ),
      ),
    );
  }
}
