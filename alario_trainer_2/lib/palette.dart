import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor primaryColor = MaterialColor(
    0xffdf8a30,
    <int, Color>{
      50: Color.fromRGBO(223, 138, 48, 0.15), //10%
      100: Color.fromRGBO(223, 138, 48, 0.25), //20%
      200: Color.fromRGBO(223, 138, 48, 0.35), //30%
      300: Color.fromRGBO(223, 138, 48, 0.45), //40%
      400: Color.fromRGBO(223, 138, 48, 0.55), //50%
      500: Color.fromRGBO(223, 138, 48, 0.65), //60%
      600: Color.fromRGBO(223, 138, 48, 0.75), //70%
      700: Color.fromRGBO(223, 138, 48, 0.85), //80%
      800: Color.fromRGBO(223, 138, 48, 0.95), //90%
      900: Color.fromRGBO(223, 138, 48, 1), //100%
    },
  );
  static const MaterialColor black = MaterialColor(
    0xff000000,
    <int, Color>{
      50: Color.fromRGBO(0, 0, 0, 0.1), //10%
      100: Color.fromRGBO(0, 0, 0, 0.2), //20%
      200: Color.fromRGBO(0, 0, 0, 0.3), //30%
      300: Color.fromRGBO(0, 0, 0, 0.4), //40%
      400: Color.fromRGBO(0, 0, 0, 0.5), //50%
      500: Color.fromRGBO(0, 0, 0, 0.6), //60%
      600: Color.fromRGBO(0, 0, 0, 0.7), //70%
      700: Color.fromRGBO(0, 0, 0, 0.8), //80%
      800: Color.fromRGBO(0, 0, 0, 0.9), //90%
      900: Color.fromRGBO(0, 0, 0, 1), //100%
    },
  );
  static const MaterialColor white = MaterialColor(0xffffffff, <int, Color>{
    50: Color.fromRGBO(255, 255, 255, 0.1),
    100: Color.fromRGBO(255, 255, 255, 0.2),
    200: Color.fromRGBO(255, 255, 255, 0.3),
    300: Color.fromRGBO(255, 255, 255, 0.4),
    400: Color.fromRGBO(255, 255, 255, 0.5),
    500: Color.fromRGBO(255, 255, 255, 0.6),
    600: Color.fromRGBO(255, 255, 255, 0.7),
    700: Color.fromRGBO(255, 255, 255, 0.8),
    800: Color.fromRGBO(255, 255, 255, 0.9),
    900: Color.fromRGBO(255, 255, 255, 1),
  });
}
