import 'package:flutter/material.dart';
import 'package:innon/resources/app_colors_const.dart';
import 'package:innon/resources/app_styles_const.dart';

class GeneralButton extends StatelessWidget {
  const GeneralButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.color = AppColors.primary,
      this.isLoading = false,
      this.vertical = 12,
      this.fontSize = 12})
      : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final bool? isLoading;
  final double? vertical;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      onPressed: onPressed,
      minWidth: double.infinity,
      color: color,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      padding: EdgeInsets.symmetric(vertical: vertical!),
      child: (isLoading!)
          ? const SizedBox(
              height: 21,
              width: 21,
              child: CircularProgressIndicator(
                  strokeWidth: 3, color: AppColors.white))
          : Text(text,
              textAlign: TextAlign.center,
              style: AppStyles.s12w500
                  .copyWith(color: AppColors.white, fontSize: fontSize)),
    );
  }
}
