import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

abstract class AppTheme {
  static darkTheme() => ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          minimumSize: const Size(double.infinity, 48),
          backgroundColor: textButtonColor,
        )),
        scaffoldBackgroundColor: scaffoldBackgroundColor,
        drawerTheme: const DrawerThemeData(
          backgroundColor: scaffoldBackgroundColor,
        ),
        appBarTheme: const AppBarTheme(backgroundColor: appBarColor),
        colorScheme: const ColorScheme(
          brightness: Brightness.dark,
          primary: scaffoldBackgroundColor,
          onPrimary: onPrimaryColor,
          secondary: secondaryColor,
          onSecondary: onPrimaryColor,
          error: errorColor,
          onError: onPrimaryColor,
          background: scaffoldBackgroundColor,
          onBackground: onPrimaryColor,
          surface: scaffoldBackgroundColor,
          onSurface: onPrimaryColor,
        ),
        textTheme: TextTheme(
          displayLarge: GoogleFonts.abel(
          fontSize: 50,
          fontWeight: FontWeight.w700,
          color: white,
        ),
          labelLarge: GoogleFonts.acme(
              fontSize: 40,
              fontWeight: FontWeight.w700,
              color: white,
          ),
          displayMedium: GoogleFonts.abel(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: white,
          ),
          labelMedium: GoogleFonts.abel(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: blue,
          ),
          displaySmall: GoogleFonts.abel(
            fontSize: 18,
            fontWeight: FontWeight.w400,
            color: bodySmallTextColor,
          ),
        ),
      );


  // TODO
  static lightTheme() => ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(color: white,fontSize: 16, fontWeight: FontWeight.w600),
          minimumSize: const Size(double.infinity, 48),
          backgroundColor: textButtonColorLight,
        )),
    scaffoldBackgroundColor: white,
    drawerTheme: const DrawerThemeData(
      backgroundColor: Colors.white,
    ),
    appBarTheme: const AppBarTheme(backgroundColor: white),
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: white,
      onPrimary: Colors.black,
      secondary: secondaryColorLight,
      onSecondary: Colors.black,
      error: errorColorLight,
      onError: Colors.black,
      background: white,
      onBackground: Colors.black,
      surface: white,
      onSurface: Colors.black,
    ),
    textTheme: TextTheme(
        displayLarge: GoogleFonts.abel(
          fontSize: 50,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        )),
);
}
