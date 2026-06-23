import 'package:flutter/material.dart';
import 'neumorphic_container.dart';

class NeumorphicButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;
  final BoxShape shape;

  const NeumorphicButton({
    super.key,
    required this.child,
    required this.onTap,
    this.borderRadius = 8.0,
    this.padding,
    this.shape = BoxShape.rectangle,
  });

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool _isPressed = false;

  void _handleTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    widget.onTap();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      child: NeumorphicContainer(
        isPressed: _isPressed,
        borderRadius: widget.borderRadius,
        padding: widget.padding,
        shape: widget.shape,
        child: widget.child,
      ),
    );
  }
}
