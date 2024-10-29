// lib/shared/widgets/custom_header.dart

import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:ogo/core/constants/colors.dart';
import 'package:ogo/core/constants/typography.dart';

class Oheader extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final String fontFamily;
  final int lines;
  final bool glow;

  // Constructor with optional properties for customization
  const Oheader({
    super.key,
    required this.text,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.w500,
    this.color = OAppColors.white,
    this.textAlign = TextAlign.center,
    this.overflow = TextOverflow.ellipsis,
    this.fontFamily = OAppFonts.primary,
    this.lines = 1,
    this.glow = false,
  });

  @override
  Widget build(BuildContext context) {
    return glow == false
        ? Text(
            text,
            maxLines: lines,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: fontFamily,
              color: color,
            ),
            textAlign: textAlign,
            overflow: overflow,
          )
        : GlowText(
            text,
            maxLines: lines,
            glowColor: OAppColors.lightwhite,
            offset: const Offset(0, 0),
            blurRadius: 10.0,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              fontFamily: fontFamily,
              color: color,
            ),
            textAlign: textAlign,
            overflow: overflow,
          );
  }
}
