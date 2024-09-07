import 'package:flutter/material.dart';

final darkTheme = ThemeData(
    scaffoldBackgroundColor: const Color.fromARGB(255, 31, 31, 31),
    appBarTheme: const AppBarTheme(
        backgroundColor: Color.fromARGB(255, 31, 31, 31),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700),
        iconTheme: IconThemeData(color: Colors.white),
    ),
    listTileTheme: const ListTileThemeData(
        iconColor: Colors.white
    ),
    textTheme: TextTheme(
      bodyMedium: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
          fontSize: 20
      ),
      labelSmall: TextStyle(
          color: Colors.white.withOpacity(0.6),
          fontWeight: FontWeight.w500,
          fontSize: 14
      ),
    )
);