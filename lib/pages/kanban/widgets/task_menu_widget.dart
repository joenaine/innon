import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innon/resources/styles.dart';

class TaskMenu extends StatelessWidget {
  final Function deleteHandler;
  const TaskMenu({
    super.key,
    required this.deleteHandler,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              top: 20.h,
              bottom: 20.h,
            ),
            child: InkWell(
              onTap: () {
                Navigator.of(context).pop();
                deleteHandler();
              },
              child: SizedBox(
                height: 40.h,
                child: Text(
                  'Delete Task',
                  style: TextStyles.textSize18Weight500
                      .copyWith(color: Palette.pink),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
