import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innon/resources/app_colors_const.dart';
import 'package:innon/resources/app_styles_const.dart';

class BoardListTile extends StatelessWidget {
  final String title;
  final Widget preview;

  const BoardListTile({Key? key, required this.title, required this.preview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      color: AppColors.white,
      height: 55,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: preview,
          ),
          SizedBox(
            width: 10.w,
          ),
          Text(
            title,
            style: AppStyles.s16w500,
          ),
        ],
      ),
    );
  }
}
