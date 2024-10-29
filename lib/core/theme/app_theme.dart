import 'package:flutter/material.dart';
import 'package:ogo/core/constants/typography.dart';
import 'package:ogo/core/theme/custom_components/app_bar_theme.dart';
import 'package:ogo/core/theme/custom_components/elevated_button_theme.dart';
import 'package:ogo/core/theme/custom_components/text_theme.dart';

class OAppTheme {
  OAppTheme._(); // private constructor

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true ,
    fontFamily: OAppFonts.primary,
    brightness: Brightness.light,
    primaryColor: Colors.amber,
    scaffoldBackgroundColor: Colors.white,
    textTheme: OTextTheme.lightTextTheme,
    elevatedButtonTheme: OElevatedButtonTheme.lightElevatedButton,
    appBarTheme: OAppBarTheme.lightAppBar,
    //////// 
    // checkboxTheme:  MaterialState.selected and all stuff
    // inputDecorationTheme:  errorMaxLines: 3 
    // textButtonTheme: 
    // chipTheme: 
    // bottomSheetTheme: 
    // outlinedButtonTheme:  
    // inputDecorationTheme:   TextField Theme
    
  

  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true ,
    fontFamily: OAppFonts.primary,
    brightness: Brightness.light,
    primaryColor: Colors.amber,
    scaffoldBackgroundColor: Colors.white,
    textTheme: OTextTheme.darkTextTheme,
    elevatedButtonTheme: OElevatedButtonTheme.darkElevatedButton,
     appBarTheme: OAppBarTheme.darkAppBar,

  );


}
