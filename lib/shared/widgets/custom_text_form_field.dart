import 'package:flutter/material.dart';
import 'package:ogo/core/constants/colors.dart';

class OtextFormField extends StatefulWidget {
  final String hintText;
  final IconData? icon;
  final Color borderColor;
  final Color focusedBorderColor;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  const OtextFormField({
    Key? key,
    required this.hintText,
    this.icon,
    this.borderColor = Colors.grey,
    this.focusedBorderColor = OAppColors.secondary,
    this.obscureText = false,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  _OtextFormFieldState createState() => _OtextFormFieldState();
}

class _OtextFormFieldState extends State<OtextFormField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,

        prefixIcon: widget.icon != null
            ? Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(widget.icon,
                    color: isFocused
                        ? widget.focusedBorderColor
                        : widget.borderColor),
              )
            : null,
        hintStyle: TextStyle(color: widget.borderColor),
        filled: true,
        // fillColor: Colors.white.withOpacity(0.1),
        fillColor:
            isFocused ? Colors.white.withOpacity(0.1) : OAppColors.primary,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: widget.borderColor, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(color: widget.focusedBorderColor, width: 2.0),
        ),
      ),
      style: const TextStyle(color: Colors.white),
      onTap: () {
        setState(() {
          isFocused = true;
        });
      },
      onFieldSubmitted: (value) {
        setState(() {
          isFocused = false;
        });
      },
    );
  }
}
