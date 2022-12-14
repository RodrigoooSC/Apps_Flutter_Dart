import 'package:flutter/material.dart';

ThemeData darkTheme() {
  return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.grey[800],
      textTheme: const TextTheme(
        headline4: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        headline5: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w200),
      ));
}

ThemeData lightTheme() {
  return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(color: Colors.purple[700]),
      textTheme: const TextTheme(
        headline4: TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold),
        headline5: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w200),
      ));
}
