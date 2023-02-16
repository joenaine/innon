import 'package:flutter/material.dart';
import 'package:innon/resources/app_colors_const.dart';
import 'package:innon/resources/app_styles_const.dart';

class TextSize {
  static Widget s18w700(String text) {
    return Text(text, style: AppStyles.s18w700);
  }

  static Widget s24w700(String text) {
    return Text(text, style: AppStyles.s24w700);
  }

  static Widget s14w500(String text, {Color? color = AppColors.gray}) {
    return Text(text, style: AppStyles.s14w500.copyWith(color: color));
  }

  static Widget s12w400(String text, {Color? color = AppColors.gray}) {
    return Text(text, style: AppStyles.s12w400.copyWith(color: color));
  }

  static Widget s12w500(String text, {Color? color = AppColors.gray}) {
    return Text(text, style: AppStyles.s12w500.copyWith(color: color));
  }

  static Widget s14w700(String text, {Color? color = AppColors.gray}) {
    return Text(text, style: AppStyles.s14w700.copyWith(color: color));
  }

  static Widget s16w500(String text, {Color? color = AppColors.dark}) {
    return Text(text, style: AppStyles.s16w500.copyWith(color: color));
  }

  static Widget s16w700(String text) {
    return Text(text, style: AppStyles.s16w700);
  }

  static Widget s16w400(String text, {Color? color = AppColors.gray}) {
    return Text(text, style: AppStyles.s16w400.copyWith(color: color));
  }

  static Widget s10w400(String text, {Color? color = AppColors.gray}) {
    return Text(text, style: AppStyles.s10w400.copyWith(color: color));
  }
}
