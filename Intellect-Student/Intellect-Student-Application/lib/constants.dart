import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6F35A5);
const kPrimaryLightColor = Color(0xFFF1E6FF);

final ThemeData kMainTheme = ThemeData(
  scaffoldBackgroundColor: Color(0xFFB1D4E0),
  primaryColor: Color(0xFF0C2D48), //inactive taskbox
  primaryColorLight: Color(0xFF2E8BC0), //Active taskbox
  accentColor: Color(0xFF145DA0), //plusIcon and edit
  errorColor: Color(0xFFD32F2F), //Delete icon
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFE4E4E4),
  ),
);

final TextStyle kBigText = TextStyle(fontSize: 24, fontWeight: FontWeight.w700);

final TextStyle kMediumText =
    TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
