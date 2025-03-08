import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:music_app/core/theme/app_pallete.dart';

class AppTheme {
  static OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderSide: BorderSide(color: color, width: 1.5),
    borderRadius: BorderRadius.circular(10),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: Pallete.backgroundColor,
    textTheme: GoogleFonts.tenorSansTextTheme().apply(
      bodyColor: Pallete.whiteColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(10),
      enabledBorder: _border(Pallete.borderColor),
      focusedBorder: _border(const Color.fromARGB(255, 156, 88, 25)),
      hintStyle: GoogleFonts.tenorSans(
        fontSize: 10,
        color: Pallete.borderColor,
      ), // Hint Text
      labelStyle: GoogleFonts.tenorSans(
        fontSize: 12,
        color: Pallete.whiteColor,
      ), // Label Text
      floatingLabelStyle: GoogleFonts.tenorSans(
        fontSize: 10,
        color: Pallete.whiteColor,
      ), // Floating Label
    ),
  );
}
