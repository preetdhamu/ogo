// import 'package:flutter/material.dart';
// import 'package:ogo/core/constants/colors.dart';

// class OtextFormField extends StatefulWidget {
//   final String hintText;
//   final IconData? icon;
//   final Color borderColor;
//   final Color focusedBorderColor;
//   final bool obscureText;
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;

//   const OtextFormField({
//     Key? key,
//     required this.hintText,
//     this.icon,
//     this.borderColor = OAppColors.grey,
//     this.focusedBorderColor = OAppColors.secondary,
//     this.obscureText = false,
//     this.controller,
//     this.validator,
//   }) : super(key: key);

//   @override
//   _OtextFormFieldState createState() => _OtextFormFieldState();
// }

// class _OtextFormFieldState extends State<OtextFormField> {
//   late FocusNode _focusNode;
//   bool isFocused = false;

//   @override
//   void initState() {
//     super.initState();
//     _focusNode = FocusNode();

//     // Listen for focus changes to update isFocused state
//     _focusNode.addListener(() {
//       setState(() {
//         isFocused = _focusNode.hasFocus;
//       });
//     });
//   }

//   @override
//   void dispose() {
//     _focusNode.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       focusNode: _focusNode,
//       validator: widget.validator,
//       controller: widget.controller,
//       obscureText: widget.obscureText,
//       decoration: InputDecoration(
//           hintText: widget.hintText,
//           prefixIcon: widget.icon != null
//               ? Padding(
//                   padding: const EdgeInsets.only(left: 8.0),
//                   child: Icon(
//                     widget.icon,
//                     color: isFocused
//                         ? widget.focusedBorderColor
//                         : widget.borderColor,
//                   ),
//                 )
//               : null,
//           hintStyle: TextStyle(color: widget.borderColor),
//           filled: true,
//           // fillColor:
//           //     isFocused ? Colors.white.withOpacity(0.1) : OAppColors.primary,
//           fillColor: OAppColors.primary,
//           enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25.0),
//             borderSide: BorderSide(color: widget.borderColor, width: 1.5),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25.0),
//             borderSide:
//                 BorderSide(color: widget.focusedBorderColor, width: 1.5),
//           ),
//           errorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25.0),
//             borderSide: BorderSide(color: OAppColors.errorRed, width: 1.5),
//           ),
//           focusedErrorBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(25.0),
//             borderSide: BorderSide(color: OAppColors.errorRed, width: 2.0),
//           ),
//           errorStyle: TextStyle(
//             color: OAppColors.errorRed,
//           )),
//       style: const TextStyle(color: Colors.white),
//     );
//   }
// }

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
    this.borderColor = OAppColors.grey,
    this.focusedBorderColor = OAppColors.secondary,
    this.obscureText = false,
    this.controller,
    this.validator,
  }) : super(key: key);

  @override
  _OtextFormFieldState createState() => _OtextFormFieldState();
}

class _OtextFormFieldState extends State<OtextFormField> {
  late FocusNode _focusNode;
  bool isFocused = false;
  String? errorText;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        TextFormField(
          focusNode: _focusNode,
          // validator: (value) {
          //   final error = widget.validator?.call(value);
          //   setState(() {
          //     errorText = error;
          //   });
          //   return null;
          // },

          validator: (value) {
            final error = widget.validator?.call(value);
            setState(() {
              errorText = error;
            });
            return error; // Returns errorText to show/hide error indicator
          },

          controller: widget.controller,
          obscureText: widget.obscureText,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: widget.icon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      widget.icon,
                      color: isFocused
                          ? widget.focusedBorderColor
                          : errorText == null
                              ? widget.borderColor
                              : OAppColors.errorRed,
                    ),
                  )
                : null,
            hintStyle: TextStyle(color: widget.borderColor),
            filled: true,
            fillColor: OAppColors.primary,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: errorText != null
                    ? OAppColors.errorRed
                    : widget.borderColor,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(
                color: errorText != null
                    ? OAppColors.errorRed
                    : widget.focusedBorderColor,
                width: 2.0,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: OAppColors.errorRed, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
              borderSide: BorderSide(color: OAppColors.errorRed, width: 2.0),
            ),
            errorStyle: const TextStyle(height: 0, fontSize: 0),

            // Hide default error space
          ),
          style: const TextStyle(color: Colors.white),
        ),
        if (errorText != null)
          Positioned(
            left: 47,
            bottom: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              color: OAppColors.primary,
              child: Text(
                errorText!,
                style: TextStyle(color: OAppColors.errorRed, fontSize: 12),
              ),
            ),
          ),
      ],
    );
  }
}
