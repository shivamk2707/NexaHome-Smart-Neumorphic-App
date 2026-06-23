import 'package:flutter/material.dart';
import 'neumorphic_container.dart';

class NeumorphicCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const NeumorphicCard({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return NeumorphicContainer(
      isPressed: false,
      borderRadius: borderRadius,
      padding: padding ?? const EdgeInsets.all(16.0),
      child: child,
    );
  }
}
