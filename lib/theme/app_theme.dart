import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF664FA3),
    scaffoldBackgroundColor: Color(0xFFE6DCF6),

    // Define text theme
    textTheme: const TextTheme(
      // Applies to all body text
      bodyLarge: TextStyle(color: Color(0xFF664FA3)),
      bodyMedium: TextStyle(color: Color(0xFF664FA3)),
      bodySmall: TextStyle(color: Color(0xFF664FA3)),

      // Applies to headlines
      headlineLarge: TextStyle(color: Color(0xFF664FA3)),
      headlineMedium: TextStyle(color: Color(0xFF664FA3)),
      headlineSmall: TextStyle(color: Color(0xFF664FA3)),

      // Applies to titles
      titleLarge: TextStyle(color: Color(0xFF664FA3)),
      titleMedium: TextStyle(color: Color(0xFF664FA3)),
      titleSmall: TextStyle(color: Color(0xFF664FA3)),

      // Applies to labels
      labelLarge: TextStyle(color: Color(0xFF664FA3)),
      labelMedium: TextStyle(color: Color(0xFF664FA3)),
      labelSmall: TextStyle(color: Color(0xFF664FA3)),
    ),

    // AppBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFE6DCF6),
      foregroundColor: Color(0xFF664FA3),
    ),

    // Global Drawer Theme
    drawerTheme: DrawerThemeData(
      backgroundColor: Color(0xFFE6DCF6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(9.0)),
      ),
    ),

    // Global ListTile Theme
    listTileTheme: ListTileThemeData(
      textColor: Color(0xFF664FA3),
      iconColor: Color(0xFF664FA3),
      tileColor: Color(0xFFE6DCF6),
      selectedColor: Color(0xFF664FA3),
      selectedTileColor: Color(0xFFF5F0F8)
          .withOpacity(0.1),
    ),

    expansionTileTheme: ExpansionTileThemeData(
      textColor: Color(0xFF664FA3),
      collapsedTextColor: Color(0xFF664FA3),
      backgroundColor: Color(0xFFE6DCF6),
      iconColor: Color(0xFF664FA3),
      collapsedIconColor: Color(0xFF664FA3),
      tilePadding: EdgeInsets.symmetric(horizontal: 16),
      expandedAlignment: Alignment.centerLeft,
    ),

    inputDecorationTheme: InputDecorationTheme(
      // Text color
      hintStyle: TextStyle(color: Color(0xFF664FA3)),
      labelStyle: TextStyle(color: Color(0xFF664FA3)),
      // Rounded border
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF664FA3)),
        borderRadius: BorderRadius.circular(30.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF664FA3)),
        borderRadius: BorderRadius.circular(30.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF664FA3)),
        borderRadius: BorderRadius.circular(30.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFF664FA3)),
        borderRadius: BorderRadius.circular(30.0),
      ),
      // Icon color from theme
      prefixIconColor: Color(0xFF664FA3),
    ),

    cardTheme: CardTheme(
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: Color(0xFF664FA3),
          width: 1,
        ),
      ),
      shadowColor: Color(0xFFE4DAF4).withOpacity(0.9),
      color: Color(0xFFE4DAF4),
    ),

    iconTheme: IconThemeData(
      color: Color(0xFF664FA3),
    ),

  );



  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.blueGrey,
    scaffoldBackgroundColor: Colors.black,

    // Define text theme
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      bodySmall: TextStyle(color: Colors.white60),
      headlineMedium: TextStyle(color: Colors.blueGrey),
    ),

    // AppBar theme
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blueGrey,
      foregroundColor: Colors.white,
    ),

    // Button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueGrey,
        foregroundColor: Colors.white,
      ),
    ),
  );
}
