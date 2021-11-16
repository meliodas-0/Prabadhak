// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData? light() {
    final textTheme = _getThemeBrightness(brightness: Brightness.light);
    ThemeData theme = ThemeData(
      primaryColor: _primaryColor,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
    );

    return theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        secondary: _secondaryColor,
      ),
    );
  }

  static ThemeData? dark() {
    final textTheme = _getThemeBrightness(brightness: Brightness.dark);
    ThemeData theme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: _primaryColor,
      backgroundColor: _primaryColor,
      textTheme: textTheme,
      primaryTextTheme: textTheme,
    );
    return theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: _secondaryColor));
  }

  static const _primaryColor = Colors.black;
  static const _secondaryColor = Colors.white;

  static _getThemeBrightness({@required Brightness? brightness}) {
    final themeData = ThemeData(brightness: brightness);

    return GoogleFonts.notoSansTextTheme(themeData.textTheme);
  }
}
