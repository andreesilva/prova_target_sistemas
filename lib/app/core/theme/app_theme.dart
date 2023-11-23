import 'package:flutter/material.dart';
import 'package:prova_target_sistemas/app/core/theme/colors.app.dart';

var colorScheme = ColorScheme.fromSeed(
  seedColor: Colors.blue,
);

var radioTheme = RadioThemeData(
  fillColor: MaterialStateColor.resolveWith((states) => colorScheme.primary),
);

var elevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        foregroundColor: colorScheme.onPrimary,
        backgroundColor: colorScheme.primary));

final ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: ColorsApp.background,
  colorScheme: colorScheme,
  useMaterial3: true,
  radioTheme: radioTheme,
  elevatedButtonTheme: elevatedButtonTheme,
  backgroundColor: Colors.blue,
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 7,
    shadowColor: Colors.blueGrey,
  ),
);
