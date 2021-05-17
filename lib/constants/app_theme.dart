import 'package:app_scanner/constants/colors.dart';
import 'package:app_scanner/constants/font_family.dart';
import 'package:flutter/material.dart';

final ThemeData themeData = new ThemeData(
    fontFamily: FontFamily.rubik,
    brightness: Brightness.light,
    primarySwatch:
        MaterialColor(AppColors.purple[500]!.value, AppColors.purple),
    primaryColor: AppColors.purple[500],
    primaryColorBrightness: Brightness.light,
    accentColor: AppColors.purple[500],
    accentColorBrightness: Brightness.light);

final ThemeData themeDataDark = ThemeData(
  fontFamily: FontFamily.rubik,
  brightness: Brightness.dark,
  primaryColor: AppColors.purple[500],
  primaryColorBrightness: Brightness.dark,
  accentColor: AppColors.purple[500],
  accentColorBrightness: Brightness.dark,
);
