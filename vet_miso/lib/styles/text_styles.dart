import 'package:flutter/material.dart';


class AppTextStyles {
  static const TextStyle appBar = TextStyle(
    fontSize: 27,
    fontWeight: FontWeight.w700,
    letterSpacing: 1,
    color: Color.fromARGB(255, 19, 26, 28),
    shadows: [
      Shadow(
        offset: Offset(1,3),
        blurRadius: 5,
        color: Color.fromRGBO(47, 47, 47, 0.39),
      ),
    ],
  );

  static const TextStyle bigTitles = TextStyle(
    fontSize: 25,
    fontWeight: FontWeight.w500,
    color: Color.fromARGB(255, 19, 26, 28),
    letterSpacing: 0.5,
    height: 1.2,
    shadows: [
      Shadow(
        offset: Offset(0, 1),
        blurRadius: 0.4,
        color: Color.fromRGBO(47, 47, 47, 1),
      ),
    ],
  );

  static const TextStyle subTitles = TextStyle(
    fontSize: 17,
    fontWeight: FontWeight.w600,
    color: Color.fromARGB(255, 19, 26, 28), 
    height: 1.4,
    letterSpacing: 0.5,
  );
}
