import 'package:flutter/material.dart';
import 'package:movie_db/config/app_colors.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    scaffoldBackgroundColor: AppColors.mainColor,

    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.mainColor,
      foregroundColor: Colors.white,
    ),
  );
}
