import 'package:flutter/material.dart';

class OAppBarTheme {
  OAppBarTheme._();
  static AppBarTheme lightAppBar = const AppBarTheme(

    color: Colors.white,
    
    elevation: 0,
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    iconTheme:  IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme:  IconThemeData(color: Colors.black, size: 24),
    titleTextStyle:TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.black),
  );
  static AppBarTheme darkAppBar = const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    scrolledUnderElevation: 0,
    
    surfaceTintColor: Colors.transparent,
    iconTheme: IconThemeData(color: Colors.black, size: 24),
    actionsIconTheme: IconThemeData(color: Colors.white, size: 24),
    titleTextStyle: TextStyle(
        fontSize: 18.0, fontWeight: FontWeight.w600, color: Colors.white),
  );
}
