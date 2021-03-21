import 'package:flutter/material.dart';

class Constants {
  static final ThemeData themeData = ThemeData(
      primaryColor: primaryColor,
      primaryColorLight: primaryLightColor,
      primaryColorDark: darkColor,
      buttonColor: primaryLightColor,
      fontFamily: 'Poppins',
      secondaryHeaderColor: secondaryColor);

  static final Color primaryColor = Colors.blueAccent;
  static final Color primaryLightColor = Colors.blueAccent.shade100;
  static final Color secondaryColor = Colors.cyanAccent;
  static final Color accentColor = Colors.white;
  static final Color lightColor = Colors.white;
  static final Color darkColor = Colors.grey[900];
  static final Color lightGreyColor = Colors.grey[400];

  static final double defaultMargin = 12;
  static final double defaultPadding = 12;
  static final double smallPadding = 6;
  static final double bigPadding = 18;
  static final double defaultRadius = 12;
  static final double smallRadius = 8;
  static final double bigRadius = 24;

  static final TextStyle titleStyle =
      TextStyle(color: lightColor, fontSize: 24, fontWeight: FontWeight.bold);
  static final TextStyle dropDownLabelStyle =
      TextStyle(color: lightColor, fontSize: 16);
  static final TextStyle dropDownMenuItemStyle =
      TextStyle(color: darkColor, fontSize: 18);
  static final viewAllStyle = TextStyle(fontSize: 14, color: primaryColor);
  static final smallTitleStyle =
      TextStyle(fontSize: 14, color: lightColor, fontWeight: FontWeight.bold);
}
