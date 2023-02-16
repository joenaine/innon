import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:innon/data/relation/relation.dart';
import 'package:innon/data/task/task.dart';
import 'package:innon/resources/app_colors_const.dart';

import 'task_text_widget.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final int columnIndex;
  final Function dragListener;
  final Function deleteItemHandler;

  const TaskCard({
    super.key,
    required this.task,
    required this.columnIndex,
    required this.dragListener,
    required this.deleteItemHandler,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: (width - 150).w,
      height: 80.h,
      margin: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4.0.h),
      child: Listener(
        onPointerMove: (PointerMoveEvent event) {
          dragListener(event);
        },
        child: LongPressDraggable<Relation>(
          feedback: Material(
            elevation: 5.0,
            color: Colors.transparent,
            child: Container(
              width: (width - 150).w,
              padding: EdgeInsets.all(16.0.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6.r),
                color: AppColors.bg,
              ),
              child: TaskText(
                title: task.title,
              ),
            ),
          ),
          childWhenDragging: Container(
            padding: EdgeInsets.all(16.0.w),
            width: 200.0.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0.r),
              color: AppColors.bg,
            ),
          ),
          data: Relation(
            from: columnIndex,
            task: task,
          ),
          child: Container(
            padding: EdgeInsets.all(12.0.w),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.r),
              color: AppColors.bg,
            ),
            child: TaskText(
              title: task.title,
            ),
          ),
        ),
      ),
    );
  }
}
