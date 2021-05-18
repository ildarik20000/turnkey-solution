import 'package:flutter/material.dart';

ThemeData playTheme =
    ThemeData(fontFamily: 'BebasBold', backgroundColor: PlayColors.background);

class PlayColors {
  static Color background = Color.fromRGBO(52, 54, 75, 1);
  static Color red = Color.fromRGBO(237, 43, 70, 1);

  static Color black100 = Color.fromRGBO(40, 40, 40, 1);
  static Color black50 = Color.fromRGBO(40, 40, 40, 0.5);
  static Color black12 = Color.fromRGBO(40, 40, 40, 0.12);
  static Color black04 = Color.fromRGBO(40, 40, 40, 0.04);

  static Color success = Color.fromRGBO(39, 174, 96, 1);
  static Color success50 = Color.fromRGBO(39, 174, 96, 0.5);
  static Color success12 = Color.fromRGBO(39, 174, 96, 0.12);
  static Color success04 = Color.fromRGBO(39, 174, 96, 0.04);

  static Color error = Color.fromRGBO(235, 87, 87, 1);
  static Color error50 = Color.fromRGBO(235, 87, 87, 0.5);
  static Color error12 = Color.fromRGBO(235, 87, 87, 0.12);
  static Color error04 = Color.fromRGBO(235, 87, 87, 0.04);

  static Color placeholder = Color.fromRGBO(233, 232, 225, 1);
  static Color buttonBackground = Color.fromRGBO(79, 179, 152, 1);

  static Color bronze = Color.fromRGBO(217, 130, 85, 1);
  static Color silver = Color.fromRGBO(179, 179, 179, 1);
  static Color gold = Color.fromRGBO(255, 204, 0, 1);
}
