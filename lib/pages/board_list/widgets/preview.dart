import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Preview extends StatelessWidget {
  final String imagePath;

  const Preview({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            imagePath,
          ),
          fit: BoxFit.fitWidth,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(4.r),
        ),
      ),
    );
  }
}
