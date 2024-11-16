// lib/shared/widgets/custom_button.dart
import 'package:flutter/material.dart';
import 'package:ogo/core/constants/colors.dart';
import 'package:ogo/core/constants/typography.dart';
import 'package:ogo/shared/widgets/custom_header.dart';

class Obutton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double fontSize;
  final double? borderRadius;
  final EdgeInsetsGeometry? padding;
  final String? img;
  double? width;
  double? height;

  Obutton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = OAppColors.darkBlue, // Default button color
    this.textColor = Colors.white, // Default text color
    this.fontSize = 18, // Default font size
    this.borderRadius = 8.0, // Default border radius
    this.img,
    this.padding = const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
    this.width,
    this.height,
  }) : super(key: key);

  @override
  State<Obutton> createState() => _ObuttonState();
}

class _ObuttonState extends State<Obutton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        width: widget.width ?? MediaQuery.of(context).size.width * 0.85,
        height: widget.height ?? MediaQuery.of(context).size.height * 0.06,
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(color: OAppColors.secondary, width: 1.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.img != null
                  ? Image.asset(
                      widget.img ?? '',
                      width: 20,
                      height: 20,
                    )
                  : const SizedBox.shrink(),
              widget.img != null
                  ? const SizedBox(
                      width: 15,
                    )
                  : const SizedBox.shrink(),
              Oheader(
                text: widget.text,
                fontSize: widget.fontSize,
                fontFamily: OAppFonts.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
