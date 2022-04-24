import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.openSansTextTheme(),
  primaryColorDark: Color.fromARGB(255, 78, 110, 93),
  primaryColorLight: Color.fromARGB(255, 77, 161, 104),
  primaryColor: Color.fromARGB(255, 59, 193, 75),
  colorScheme: const ColorScheme.light(secondary: Color(0xFF4D5057)),
  scaffoldBackgroundColor: Color.fromARGB(255, 207, 207, 207),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);
