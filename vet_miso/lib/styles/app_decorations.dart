import 'package:flutter/material.dart';

class AppDecorations {
  static BoxDecoration loginContainer = BoxDecoration(
    color: Colors.white.withOpacity(0.8),
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: const Color.fromARGB(255, 241, 238, 238).withAlpha(25),
        blurRadius: 15,
        spreadRadius: 5,
      ),
    ],
  );

  static BoxDecoration iconCircle = BoxDecoration(
    color: const Color.fromARGB(255, 221, 221, 221).withOpacity(0.1),
    shape: BoxShape.circle,
  );

  static BoxDecoration backgroundOverlay = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
      Colors.white.withOpacity(0.2),
      Colors.white.withOpacity(0.2),
      ],
    ),
  );
}