import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:innon/resources/app_assets.dart';
import 'package:innon/resources/app_colors_const.dart';
import 'package:innon/resources/app_styles_const.dart';

class DiscoloredButton extends StatelessWidget {
  const DiscoloredButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isAddIcon = false,
    this.color = AppColors.primary,
  }) : super(key: key);
  final String text;
  final VoidCallback onPressed;
  final bool? isLoading;
  final bool? isAddIcon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: BorderSide(color: color!)),
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: (isLoading!)
          ? const SizedBox(
              height: 21,
              width: 21,
              child: CircularProgressIndicator(
                  strokeWidth: 3, color: AppColors.white))
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isAddIcon!) ...[
                  SvgPicture.asset(
                    AppAssets.svg.addiconbutton,
                    color: color,
                  ),
                  const SizedBox(width: 4),
                ],
                Text(
                  text,
                  textAlign: TextAlign.center,
                  style: AppStyles.s16w500.copyWith(color: color),
                ),
              ],
            ),
    );
  }
}
