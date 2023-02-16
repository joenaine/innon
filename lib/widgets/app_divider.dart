import 'package:flutter/material.dart';
import 'package:innon/resources/app_colors_const.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: Divider(
        color: AppColors.gray,
        thickness: .3,
      ),
    );
  }
}

class AppSheetDivider extends StatelessWidget {
  const AppSheetDivider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: AppColors.gray,
      thickness: .3,
    );
  }
}
