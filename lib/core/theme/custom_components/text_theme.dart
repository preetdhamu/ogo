import 'package:flutter/material.dart';

class OTextTheme {
  OTextTheme._();
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 22 ,fontWeight: FontWeight.bold , color: Colors.black),
    headlineMedium: const TextStyle().copyWith(fontSize: 18 ,fontWeight: FontWeight.w600 , color: Colors.black),
    headlineSmall: const TextStyle().copyWith(fontSize: 16 ,fontWeight: FontWeight.w800 , color: Colors.black),
    labelLarge: const TextStyle().copyWith(fontSize: 14 , fontWeight: FontWeight.w600 , color : Colors.black),
    labelMedium: const TextStyle().copyWith(fontSize: 12 , fontWeight: FontWeight.w500 , color : Colors.black),
    labelSmall: const TextStyle().copyWith(fontSize: 10 , fontWeight: FontWeight.w500 , color : Colors.black),
  );
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: 22 ,fontWeight: FontWeight.bold , color: Colors.white),
    headlineMedium: const TextStyle().copyWith(fontSize: 18 ,fontWeight: FontWeight.w600 , color: Colors.white),
    headlineSmall: const TextStyle().copyWith(fontSize: 16 ,fontWeight: FontWeight.w800 , color: Colors.white),
    labelLarge: const TextStyle().copyWith(fontSize: 14 , fontWeight: FontWeight.w600 , color : Colors.white),
    labelMedium: const TextStyle().copyWith(fontSize: 12 , fontWeight: FontWeight.w500 , color : Colors.white),
    labelSmall: const TextStyle().copyWith(fontSize: 10 , fontWeight: FontWeight.w500 , color : Colors.white),
  );
}
