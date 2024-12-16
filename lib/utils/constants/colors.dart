import 'package:flutter/material.dart';

class AppColors {
  // Background Colors
  static const Color scaffoldLightColor = Color(0xffFFFFFF);
  static const Color scaffoldDarkColor = Color(0xff121212);

  // Primary Colors
  static const Color primaryColor = Color(0xff5654D4);
  static const Color secondaryColor = Color(0xffFF9F0A);
  static const Color accentColor = Color(0xff1DBF73);

  // Text Colors
  static const Color textPrimaryColor = Color(0xff000000);
  static const Color textSecondaryColor = Color(0xff6B6B6B);

  // Border Colors
  static const Color borderColor = Color(0xff949494);

  // Shadow Colors
  static const Color shadowLightColor = Color(0xff0000001a);
  static const Color shadowDarkColor = Color(0xff00000014);

  // Input Field Colors
  static const Color inputLightColor = Color(0xffF5F5F5);
  static const Color inputDarkColor = Color(0xff2C2C2C);

  // Error Colors
  static const Color errorColor = Color(0xffFF3B30);

  // New Added Color
  static const Color appBarDarkColor = Color(0xff6B6B6B);
  static const Color appBarLightColor = Color(0xffF8F9FA);

  //App ColorPallete
  static const Color darkBlue = Color(0xff0A1128);
  static const Color blue = Color(0xff001F54);
  static const Color mediumBlue = Color(0xff034078);
  static const Color lightBlue = Color(0xff1282A2);
  static const Color offWhite = Color(0xffFEFCFB);

  static LinearGradient buttonGradient = const LinearGradient(
    colors: [
      // Color(0xff0A1128),
      Color(0xff001F54),
      Color(0xff034078),
      // Color(0xff1282A2),
    ],
    stops: [0, 0.5],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  // Gradient Colors
  static LinearGradient PinkGradient = const LinearGradient(
    colors: [
      Color(0xffC6DBFF),
      Color(0xffE7CCFF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static LinearGradient backgroundGradient = const LinearGradient(
    colors: [
      Color(0xffFFFFFF),
      Color(0xffF1F1F1),
    ],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );



}
