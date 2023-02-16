import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innon/resources/app_colors_const.dart';
import 'package:innon/resources/styles.dart';

class ExportMenu extends StatelessWidget {
  final VoidCallback exportHandler;

  const ExportMenu({
    super.key,
    required this.exportHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 20.w,
              bottom: 20.w,
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                exportHandler();
              },
              child: SizedBox(
                height: 40.h,
                child: Text(
                  'Export CSV',
                  style: TextStyles.textSize18Weight500
                      .copyWith(color: AppColors.primary),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
