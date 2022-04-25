import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  textTheme: GoogleFonts.openSansTextTheme(),
  primaryColorDark: Color.fromARGB(164, 76, 84, 84),
  primaryColorLight: Color.fromARGB(211, 235, 235, 235),
  primaryColor: Color.fromARGB(230, 227, 242, 253),
  colorScheme: const ColorScheme.light(secondary: Color(0xFF4D5057)),
  scaffoldBackgroundColor: Color(0xFFEBEBEB),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  ),
);

final Color appBarColor = Color(0xFF1EA896);
