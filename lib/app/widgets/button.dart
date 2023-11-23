import 'package:flutter/material.dart';
import 'package:prova_target_sistemas/app/core/theme/colors.app.dart';

final button = ElevatedButton.styleFrom(
  backgroundColor: ColorsApp.button,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
  ),
  elevation: 2,
  shadowColor: Colors.blueGrey,
);
