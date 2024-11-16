import 'dart:ui';
import 'package:flutter/material.dart';

class GlassMorphism extends StatelessWidget {
  const GlassMorphism(
      {Key? key,
      required this.child,
      required this.blur,
      required this.opacity,
      required this.color,
      this.margin,
      this.width,
      this.height,
      this.borderRadius})
      : super(key: key);
  final Widget child;
  final double blur;
  final double opacity;
  final Color color;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? margin;

  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          width: width,
          height: height,
          margin: margin,
          decoration: BoxDecoration(
              color: color.withOpacity(opacity), borderRadius: borderRadius),
          child: child,
        ),
      ),
    );
  }
}
