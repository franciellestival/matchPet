import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme/layout/app_config.dart';

const globalFontFamily = 'Lato';

final themeData = ThemeData(
  textTheme: const TextTheme(
    headline1: TextStyle(
      fontFamily: globalFontFamily,
      fontSize: 50.0,
      fontWeight: FontWeight.w300,
      letterSpacing: 3,
    ),
    headline2: TextStyle(
      color: AppColors.white,
      fontFamily: globalFontFamily,
      fontSize: 30.0,
      fontWeight: FontWeight.w900,
      letterSpacing: 2,
    ),
    headline3: TextStyle(
      fontFamily: globalFontFamily,
      fontSize: 25.0,
      fontWeight: FontWeight.w600,
      letterSpacing: 2,
    ),
    headline4: TextStyle(
      fontFamily: globalFontFamily,
      fontSize: 13.0,
      fontWeight: FontWeight.w300,
      letterSpacing: 2,
    ),
    headline5: TextStyle(
      fontFamily: globalFontFamily,
      fontSize: 10.0,
      fontWeight: FontWeight.w300,
      letterSpacing: 2,
    ),
    headline6: TextStyle(
      fontFamily: globalFontFamily,
      fontSize: 5.0,
      fontWeight: FontWeight.w300,
      letterSpacing: 1,
    ),
    subtitle1: TextStyle(
      fontFamily: globalFontFamily,
      fontSize: 5.0,
      fontWeight: FontWeight.w300,
      letterSpacing: 1,
    ),
    subtitle2: TextStyle(
      fontFamily: globalFontFamily,
      fontSize: 5.0,
      fontWeight: FontWeight.w300,
      letterSpacing: 1,
    ),
    bodyText1: TextStyle(
      fontFamily: globalFontFamily,
      fontSize: 5.0,
      fontWeight: FontWeight.w300,
      letterSpacing: 1,
    ),
    bodyText2: TextStyle(
      fontFamily: globalFontFamily,
      fontSize: 5.0,
      fontWeight: FontWeight.w300,
      letterSpacing: 1,
    ),
    caption: TextStyle(
      fontFamily: globalFontFamily,
      fontSize: 5.0,
      fontWeight: FontWeight.w300,
      letterSpacing: 1,
    ),
    button: TextStyle(
      fontFamily: globalFontFamily,
      fontSize: 5.0,
      fontWeight: FontWeight.w300,
      letterSpacing: 1,
    ),
    overline: TextStyle(
      fontFamily: globalFontFamily,
      fontSize: 5.0,
      fontWeight: FontWeight.w300,
      letterSpacing: 1,
    ),
  ),
);

final Uint8List kTransparentImage = Uint8List.fromList(<int>[
  0x89,
  0x50,
  0x4E,
  0x47,
  0x0D,
  0x0A,
  0x1A,
  0x0A,
  0x00,
  0x00,
  0x00,
  0x0D,
  0x49,
  0x48,
  0x44,
  0x52,
  0x00,
  0x00,
  0x00,
  0x01,
  0x00,
  0x00,
  0x00,
  0x01,
  0x08,
  0x06,
  0x00,
  0x00,
  0x00,
  0x1F,
  0x15,
  0xC4,
  0x89,
  0x00,
  0x00,
  0x00,
  0x0A,
  0x49,
  0x44,
  0x41,
  0x54,
  0x78,
  0x9C,
  0x63,
  0x00,
  0x01,
  0x00,
  0x00,
  0x05,
  0x00,
  0x01,
  0x0D,
  0x0A,
  0x2D,
  0xB4,
  0x00,
  0x00,
  0x00,
  0x00,
  0x49,
  0x45,
  0x4E,
  0x44,
  0xAE,
]);