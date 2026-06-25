import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_button.dart';
import '../../../core/widgets/neumorphic_container.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  Future<void> _launchUrl(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url)) {
      debugPrint('Could not launch $url');
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
        title: Text('Help & Support', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('FAQ', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 16.h),
              _buildFaqItem(context, 'How to add a new device?', 'To add a new device, tap the "+" button on the Home Dashboard or go to the Devices tab and tap Add Device. Make sure your new device is in pairing mode.'),
              SizedBox(height: 16.h),
              _buildFaqItem(context, 'How to share access?', 'Go to the Profile tab, then select "Home Members". You can add new members and assign them Roles (Admin or Member) to grant access to your home.'),
              SizedBox(height: 16.h),
              _buildFaqItem(context, 'Device offline troubleshooting', 'Ensure your Wi-Fi is active and the device is plugged in. If the problem persists, try restarting your home hub or router.'),

              SizedBox(height: 48.h),
              Text('Contact Us', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
              SizedBox(height: 16.h),
              _buildContactItem(context, 'Live Chat', Icons.chat, () => _launchUrl('https://example.com/chat')),
              SizedBox(height: 16.h),
              _buildContactItem(context, 'Email Support', Icons.email, () => _launchUrl('mailto:support@nexahome.app?subject=Support%20Request')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFaqItem(BuildContext context, String question, String answer) {
    return NeumorphicContainer(
      borderRadius: 16.r,
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: AppColors.primary,
          collapsedIconColor: AppColors.lightTextSecondary,
          title: Text(question, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface)),
          childrenPadding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 16.h),
          children: [
            Text(answer, style: AppTextStyles.bodyMedium(AppColors.lightTextSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem(BuildContext context, String text, IconData icon, VoidCallback onTap) {
    return NeumorphicButton(
      onTap: onTap,
      borderRadius: 16.r,
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary),
          SizedBox(width: 16.w),
          Expanded(child: Text(text, style: AppTextStyles.labelMedium(Theme.of(context).colorScheme.onSurface))),
          Icon(Icons.chevron_right, color: AppColors.lightTextSecondary),
        ],
      ),
    );
  }
}
