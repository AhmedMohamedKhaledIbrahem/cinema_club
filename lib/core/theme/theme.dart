import 'package:cinema_club/constants/colors/colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: MyColors.accentBlue,
      iconTheme: IconThemeData(color: Colors.grey[900]),
      scaffoldBackgroundColor: Colors.white,
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 20.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
            fontSize: 15.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
            height: 1),
        bodySmall: TextStyle(
          fontSize: 12.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: MyColors.blueGray,
        selectedItemColor: MyColors.accentBlue,
        unselectedItemColor: Colors.white,
        //selectedIconTheme: IconThemeData(color: MyColors.accentBlue),
      ),
      inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black), // Input Border Color
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF2196F3))),
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: TextStyle(color: Colors.red),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          fillColor: Colors.white // Label Color
          ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          splashFactory: InkRipple.splashFactory,
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Rounded corner
            ),
          ),
          overlayColor: WidgetStateProperty.all(Colors.grey[100]),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.softBlue,
        ),
      ),
      cardTheme: CardTheme(color: Colors.grey[200]),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.black,
        selectionColor: MyColors.blue,
        selectionHandleColor: MyColors.blue,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.black,
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: MyColors.accentBlue,
      scaffoldBackgroundColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.white),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          fontSize: 20.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        bodyMedium: TextStyle(
          fontSize: 15.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          height: 1,
        ),
        bodySmall: TextStyle(
          fontSize: 12.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: MyColors.blueGray,
        selectedItemColor: MyColors.accentBlue,
        unselectedItemColor: MyColors.white,
        //selectedIconTheme: IconThemeData(color: MyColors.accentBlue),
      ),
      inputDecorationTheme: const InputDecorationTheme(
          /*border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white), // Input Border Color
            ),*/

          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: MyColors.blue),
          ),
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          errorStyle: TextStyle(color: Colors.red),
          focusedErrorBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          fillColor: Colors.black // Label Color
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: MyColors.softBlue,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          splashFactory: InkRipple.splashFactory,
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Rounded corner
            ),
          ),
          overlayColor: WidgetStateProperty.all(Colors.grey[800]),
        ),
      ),
      cardTheme: CardTheme(
        color: Colors.grey[900],
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: Colors.white,
        selectionColor: MyColors.blue,
        selectionHandleColor: MyColors.blue,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: Colors.white,
      ),
    );
  }
}
