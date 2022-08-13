import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor primaryColor = MaterialColor(
    0xffdf8a30,
    <int, Color>{
      50: Color(0xffc97c2b), //10%
      100: Color(0xffb26e26), //20%
      200: Color(0xff9c6122), //30%
      300: Color(0xff86531d), //40%
      400: Color(0xff704518), //50%
      500: Color(0xff593713), //60%
      600: Color(0xff43290e), //70%
      700: Color(0xff2d1c0a), //80%
      800: Color(0xff160e05), //90%
      900: Color(0xff000000), //100%
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
