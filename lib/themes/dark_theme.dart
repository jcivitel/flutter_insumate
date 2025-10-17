import 'package:flutter/material.dart';

final darkTheme = ThemeData(
  primarySwatch: Colors.green,
  brightness: Brightness.dark,
  primaryColor: Colors.green[700],
  scaffoldBackgroundColor: Colors.grey[600],
  cardTheme: CardThemeData(
    color: Colors.grey[800],
    shadowColor: Colors.black,
    elevation: 5,
    margin: const EdgeInsets.all(10),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.green[700],
    actionsIconTheme: IconThemeData(color: Colors.grey[200]),
    iconTheme: IconThemeData(color: Colors.grey[200]),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Colors.green[700],
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(color: Colors.green[700]),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: Colors.green[700],
      side: BorderSide(color: Colors.green[700]!),
    ),
  ),
);
