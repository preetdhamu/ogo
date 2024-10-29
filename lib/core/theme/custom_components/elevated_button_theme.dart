import 'package:flutter/material.dart';

class OElevatedButtonTheme {
  OElevatedButtonTheme._();
  static ElevatedButtonThemeData? lightElevatedButton =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue ,
          disabledForegroundColor: Colors.grey ,
          disabledBackgroundColor: Colors.grey ,
          side: const BorderSide(color: Colors.blue),
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12) ),
        )
      );
      static ElevatedButtonThemeData? darkElevatedButton =
      ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          foregroundColor: Colors.white,
          backgroundColor: Colors.blue ,
          disabledForegroundColor: Colors.grey ,
          disabledBackgroundColor: Colors.grey ,
          side: const BorderSide(color: Colors.blue),
          shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(12) ),
        )
      );
  
}
