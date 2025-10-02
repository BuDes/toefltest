import 'package:flutter/material.dart';
import 'package:toeflapp/theme/app_colors.dart';

class GradientBorderContainer extends StatelessWidget {
  final Widget child;
  final Gradient gradient;
  final double borderRadius;
  final double strokeWidth;
  final EdgeInsets padding;

  const GradientBorderContainer({
    super.key,
    required this.child,
    this.gradient = const LinearGradient(
      colors: [AppColors.primary, Colors.orange],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    this.borderRadius = 16,
    this.strokeWidth = 2,
    this.padding = const EdgeInsets.all(16),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        gradient: gradient,
      ),
      child: Container(
        margin: EdgeInsets.all(strokeWidth),
        padding: padding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24 - strokeWidth),
        ),
        child: child,
      ),
    );
  }
}
