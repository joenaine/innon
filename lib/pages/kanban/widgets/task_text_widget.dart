import 'package:flutter/material.dart';
import 'package:innon/resources/app_styles_const.dart';

class TaskText extends StatelessWidget {
  const TaskText({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: AppStyles.s12w500,
    );
  }
}
