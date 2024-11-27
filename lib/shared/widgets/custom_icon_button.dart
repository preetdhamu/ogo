import 'dart:ui';
import 'package:flutter/material.dart';

class OiconButtons extends StatefulWidget {
  final Widget? child;
  final Function()? onTap;
  bool? extra = true;

  OiconButtons({
    Key? key,
    required this.child,
    required this.onTap,
    this.extra,
  }) : super(key: key);

  @override
  State<OiconButtons> createState() => _OiconButtonsState();
}

class _OiconButtonsState extends State<OiconButtons> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          color:
              Colors.white.withOpacity(0.2), // Frosted glass background effect
          borderRadius: BorderRadius.circular(50.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Dark shadow for depth
              offset: Offset(4, 4),
              blurRadius: 10,
            ),
            BoxShadow(
              color: Colors.white
                  .withOpacity(0.2), // Inner glow for frosted effect
              offset: Offset(-4, -4),
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(50.0),
          child: BackdropFilter(
            filter: ImageFilter.blur(
                sigmaX: 10.0, sigmaY: 10.0), // Frosted glass blur effect
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
              decoration: widget.extra == true
                  ? BoxDecoration(
                      color: Colors.white.withOpacity(
                          0.2), // Slight background color for clarity
                      shape: BoxShape.circle,
                    )
                  : null,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
