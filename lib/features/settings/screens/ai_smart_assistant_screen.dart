import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/neumorphic_container.dart';

class AiSmartAssistantScreen extends StatefulWidget {
  const AiSmartAssistantScreen({super.key});

  @override
  State<AiSmartAssistantScreen> createState() => _AiSmartAssistantScreenState();
}

class _AiSmartAssistantScreenState extends State<AiSmartAssistantScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {'text': 'Hello! How can I help you manage your home today?', 'isUser': false},
  ];
  final ScrollController _scrollController = ScrollController();
  bool _isTyping = false;

  void _sendMessage() async {
    if (_controller.text.trim().isEmpty) return;

    final text = _controller.text.trim();
    setState(() {
      _messages.add({'text': text, 'isUser': true});
      _isTyping = true;
    });
    _controller.clear();
    _scrollToBottom();

    await Future.delayed(const Duration(seconds: 1));

    String reply = "I'm sorry, I didn't understand that command.";
    if (text.toLowerCase().contains('turn on') && text.toLowerCase().contains('ac')) {
      reply = "The AC has been turned on and set to 24 degrees.";
    } else if (text.toLowerCase().contains('lights') && text.toLowerCase().contains('off')) {
      reply = "All lights have been turned off.";
    }

    if (mounted) {
      setState(() {
        _messages.add({'text': reply, 'isUser': false});
        _isTyping = false;
      });
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
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
        title: Text('Nexa AI', style: AppTextStyles.headlineMedium(Theme.of(context).colorScheme.onSurface)),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                controller: _scrollController,
                padding: EdgeInsets.all(24.w),
                itemCount: _messages.length + (_isTyping ? 1 : 0),
                separatorBuilder: (_, __) => SizedBox(height: 16.h),
                itemBuilder: (context, index) {
                  if (index == _messages.length) {
                    return _buildMessage(context, '...', false);
                  }
                  final msg = _messages[index];
                  return _buildMessage(context, msg['text'], msg['isUser']);
                },
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
                        controller: _controller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type your message...',
                          hintStyle: AppTextStyles.bodyMedium(AppColors.lightTextSecondary),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send, color: AppColors.primary),
                      onPressed: _sendMessage,
                    ),
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
