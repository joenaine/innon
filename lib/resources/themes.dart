import 'package:flutter/material.dart';

import 'app_colors_const.dart';
import 'app_styles_const.dart';

abstract class Themes {
  static final ThemeData defaultTheme = ThemeData(
    fontFamily: 'Nunito',
    scaffoldBackgroundColor: AppColors.bg,
    appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors.white,
        toolbarTextStyle: AppStyles.s14w400,
        titleTextStyle: AppStyles.s16w500,
        iconTheme: IconThemeData(color: AppColors.dark)),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      showSelectedLabels: true,
      showUnselectedLabels: true,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.grayLight,
      backgroundColor: AppColors.white,
    ),
  );
}
