import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarAction extends StatelessWidget {
  final VoidCallback onTap;
  final IconData icon;

  const AppBarAction({Key? key, required this.onTap, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        right: 22.w,
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Icon(icon),
      ),
    );
  }
}
