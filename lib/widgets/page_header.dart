import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innon/resources/styles.dart';

class PageHeader extends StatelessWidget {
  final String title;
  final Icon icon;
  const PageHeader({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        16.w,
        32.h,
        16.w,
        18.h,
      ),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: 12.w,
          ),
          Text(
            title,
            style: TextStyles.textSize18Weight600.copyWith(
              color: Palette.grey2,
            ),
          ),
        ],
      ),
    );
  }
}
