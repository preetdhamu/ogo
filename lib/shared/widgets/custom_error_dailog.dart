import 'package:flutter/material.dart';
import 'package:ogo/core/constants/colors.dart';
import 'package:ogo/shared/widgets/custom_header.dart';


void OshowInfoDialog(
    BuildContext context, String errorMessage, String errorTitle,
    {IconData? errorIcon = Icons.error}) {
  Color? backgroundColor;
  switch (errorIcon) {
    case Icons.close:
      backgroundColor = OAppColors.errorRed;
      break;
    case Icons.info:
      backgroundColor = OAppColors.secondary;
    default:
      backgroundColor = OAppColors.grey;
  }
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        backgroundColor: backgroundColor,
        title: Row(
          children: [
            Icon(errorIcon, color: Colors.white),
            const SizedBox(width: 8),
            Oheader(
              text: errorTitle,
              glow: true,
              textAlign: TextAlign.center,
              color: OAppColors.white,
            ),
            // Text(
            //   errorTitle,
            //   style: TextStyle(color: Colors.white),
            // ),
          ],
        ),
        content: Text(
          errorMessage,
          style: TextStyle(color: Colors.white70),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Close',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      );
    },
  );
}
