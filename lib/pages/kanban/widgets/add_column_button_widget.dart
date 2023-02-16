import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innon/resources/styles.dart';

class AddColumnButton extends StatelessWidget {
  final Function addColumnAction;

  const AddColumnButton({super.key, required this.addColumnAction});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () {
            addColumnAction();
          },
          child: Container(
            width: (width - 150).w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              color: Palette.grey9,
            ),
            margin: EdgeInsets.fromLTRB(16.w, 32.h, 16.w, 100.h),
            padding: EdgeInsets.all(14.w),
            child: Center(
              child: Text(
                "Add list",
                style: TextStyles.textSize14Weight400.copyWith(
                  color: Palette.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
