import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class AppThemeData {
  static final AppThemeData _instance = AppThemeData._internal();

  factory AppThemeData() {
    return _instance;
  }

  AppThemeData._internal();

  final Color primary = Color(0xff996323);
  final Color secondary = Color(0xff0b143a);
  final Color backgroundClr = Color(0xff050915);
  final Color navBackClr = Color(0xff060E27);
  final Color white = Colors.white;
  final Color black = Colors.black;
  final Color grey = Colors.grey;
  final Color transparent = Colors.transparent;
  final Color yellow = Colors.yellow;
  final Color red = Colors.red;
  final Color orange = Color(0xffD0624C);
  final Color getStartedButtonColor = Color(0xff0C192B);
  final Color green = Color(0xff0A6375);
  final Color surface = const Color(0xFFF2F2F2);
  final Color color25 = Color(0xffF6F8FA);
  final Color color50 = Color(0xffF9FAFB);
  final Color color100 = Color(0xffF7F9FC);
  final Color color200 = Color(0xffE2E8F0);
  final Color color300 = Color(0xffCBD5E1);
  final Color color400 = Color(0xff94A3B8);
  final Color color500 = Color(0xff6B7280);
  final Color color600 = Color(0xff475569);
  final Color color900 = Color(0xff080A12);
  final Color textColor = Colors.white;
  final Color textLightColor = Color(0xff606060);
  final Color disableBtnBck = Color(0xffECECEC);
  final Color disableBtntext = Color.fromRGBO(4, 12, 34, 0.40);
  final Color jobTags = Color.fromRGBO(246, 248, 250, 0.60);
  final Color unSelectedStar = Color(0xffEDF1F7);
  final Color selectedStar = Color(0xffD0624C);
  final Color borderFocused = Color(0xffF87171);
  final Color borderUnfocused = Color(0xffCBD5E1);
  final Color cursorColor = Colors.white;
  final Color cursorColorDark = Colors.white;

  // Dark Theme Colors
  final Color darkPrimary = const Color(0xFF1A73E8);
  final Color darkBackground = const Color(0xFF212121);
  final Color darkSurface = const Color(0xFF1E1E1E);
  final Color darkText = Colors.white;

  // Text Colors
  final Color textPrimary = const Color(0xFF212121);
  final Color textSecondary = const Color(0xff606060);
  final Color textHint = const Color(0xFF9E9E9E);
  final Color textDisabled = const Color(0xFFBDBDBD);

  // Error and Success Colors
  final Color error = Colors.redAccent;
  final Color success = Colors.green;

  // Box Decoration Color
  static Color lightBoxDecorationColor = Color(0xFFECEFF1);
  static Color darkBoxDecorationColor = Color(0xFF1E1E1E);

  bool isDarkMode = false;

  // Method to apply system UI style based on theme mode
  void applySystemUIOverlayStyle(ThemeMode themeMode) {
    if (isDarkMode = WidgetsBinding.instance.window.platformBrightness == Brightness.dark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: color600, // Status bar color for dark theme
        statusBarIconBrightness: Brightness.light, // Light icons for dark theme
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: secondary, // Status bar color for light theme
        statusBarIconBrightness: Brightness.light, // Dark icons for light theme
      ));
    }
  }

  // Light Theme
  ThemeData get light {
    final base = ThemeData.light();
    final colorScheme = ColorScheme.light(
      primary: primary,
      secondary: secondary,
      background: backgroundClr,
      surface: white,
      onPrimary: grey,
      onSecondary: black,
      onBackground: textColor,
      onSurface: textColor,
      error: error,
    );

    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.background,

      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: backgroundClr,
        foregroundColor: white,
      ),
      bottomNavigationBarTheme: base.bottomNavigationBarTheme.copyWith(
        selectedItemColor: primary,
        unselectedItemColor: grey,
        backgroundColor: navBackClr,
        type: BottomNavigationBarType.fixed,
      ),
      textTheme: base.textTheme.copyWith(
        bodyLarge: base.textTheme.bodyLarge!.copyWith(color: colorScheme.onBackground),
        labelLarge: base.textTheme.labelLarge!.copyWith(color: colorScheme.onPrimary),
      ),
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: colorScheme.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      iconTheme: base.iconTheme.copyWith(
        color: colorScheme.onBackground,
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        hintStyle: GoogleFonts.inter().copyWith(
          color: textSecondary,
        ),
        labelStyle: TextStyle(color: colorScheme.onSurface),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: textSecondary),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.error),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.error, width: 2),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
        backgroundColor: colorScheme.primary,
      ),
      snackBarTheme: base.snackBarTheme.copyWith(
        backgroundColor: colorScheme.primary,
      ),
      textSelectionTheme: base.textSelectionTheme.copyWith(
        selectionColor: secondary,
        cursorColor: primary,
      ),
        // switchTheme: SwitchThemeData(
        //   thumbColor: WidgetStateProperty.all(switchInactiveThumbColor),
        //   trackColor: WidgetStateProperty.all(switchInactiveTrackColor),
        //   activeTrackColor: WidgetStateProperty.all(switchActiveTrackColor),
        //   activeColor: WidgetStateProperty.all(switchActiveColor),
        // ),
        //
    );
  }

  // Dark Theme
  ThemeData get dark {
    final base = ThemeData.dark();
    final colorScheme = ColorScheme.dark(
      primary: darkPrimary,
      secondary: secondary,
      background: darkBackground,
      surface: darkBackground,
      onPrimary: darkText,
      onSecondary: darkText,
      onBackground: darkText,
      onSurface: darkText,
      error: error,
    );

    return base.copyWith(
      colorScheme: colorScheme,
      primaryColor: colorScheme.primary,
      scaffoldBackgroundColor: colorScheme.background,
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: color600,
        foregroundColor: white,
      ),
      textTheme: base.textTheme.copyWith(
        bodyLarge: base.textTheme.bodyLarge!.copyWith(color: colorScheme.onBackground),
        labelLarge: base.textTheme.labelLarge!.copyWith(color: colorScheme.onPrimary),
      ),
      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: colorScheme.primary,
        textTheme: ButtonTextTheme.primary,
      ),
      iconTheme: base.iconTheme.copyWith(
        color: colorScheme.onBackground,
      ),
      inputDecorationTheme: base.inputDecorationTheme.copyWith(
        border: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        hintStyle: GoogleFonts.inter().copyWith(
          color: color400,
        ),
        // focusedBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: colorScheme.secondary),
        // ),
        // enabledBorder: OutlineInputBorder(
        //   borderSide: BorderSide(color: colorScheme.primary),
        // ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: colorScheme.error),
        ),
        labelStyle: TextStyle(color: colorScheme.onSurface),
      ),
      floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
        backgroundColor: colorScheme.primary,
      ),
      snackBarTheme: base.snackBarTheme.copyWith(
        backgroundColor: colorScheme.primary,
      ),
      textSelectionTheme: base.textSelectionTheme.copyWith(
        selectionColor: secondary,
        cursorColor: primary,
      ),
    );
  }
}
