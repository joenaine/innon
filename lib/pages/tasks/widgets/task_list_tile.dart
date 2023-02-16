import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innon/resources/app_colors_const.dart';
import 'package:innon/resources/styles.dart';

class TaskListTile extends StatelessWidget {
  final String title;
  final String completionDate;
  final String timeSpent;

  const TaskListTile(
      {Key? key,
      required this.title,
      required this.completionDate,
      required this.timeSpent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.fromLTRB(16.0.w, 16.h, 16.w, 8.h),
        margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.r),
          color: AppColors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyles.textSize14Weight400
                  .copyWith(color: AppColors.dark),
            ),
            SizedBox(
              height: 18.h,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.r),
                    color: Palette.pink,
                  ),
                  child: Text(
                    completionDate,
                    style: TextStyles.textSize13Weight400
                        .copyWith(color: Palette.white),
                  ),
                ),
                SizedBox(
                  width: 18.h,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 6.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3.r),
                    color: Palette.green,
                  ),
                  child: Text(
                    'Time spent: $timeSpent',
                    style: TextStyles.textSize13Weight400
                        .copyWith(color: Palette.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
