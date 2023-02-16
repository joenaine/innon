import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Styles - Contains the design system for the entire app.
/// Includes colors, text styles etc.

// Palette
abstract class Palette {
  static const Color transparent = Colors.transparent;
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color blue = Color(0xFF2590CA);
  static const Color blue2 = Color(0xFF0777B6);
  static const Color grey = Color(0xFF2C2C2E);
  static const Color grey2 = Color(0xFF9397A1);
  static const Color grey3 = Color(0xFF1C1C1E);
  static const Color grey4 = Color(0xffDCDCDC);
  static const Color grey5 = Color(0xff6C6C6E);
  static const Color grey6 = Color(0xff4D5669);
  static const Color grey7 = Color(0xffA8AFBF);
  static const Color grey8 = Color(0xff5D5C60);
  static const Color grey9 = Color(0xAD2C2C2E);
  static const Color grey10 = Color(0xFF5B5F67);
  static const Color grey11 = Color(0xFF9E9DA3);
  static const Color grey12 = Color(0xFF5F5F61);
  static const Color darkBlue = Color(0xff324661);
  static const Color pink = Color(0xffEC948B);
  static const Color green = Color(0xff58AB44);
}

abstract class TextStyles {
  static final TextStyle textSize13Weight500 = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle textSize13Weight400 = TextStyle(
    fontSize: 13.sp,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle textSize14Weight400 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle textSize14Weight500 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle textSize16Weight400 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle textSize16Weight600 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle textSize18Weight600 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );
  static final TextStyle textSize18Weight500 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle textSize18Weight400 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w400,
  );
  static final TextStyle textSize24Weight700 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle textSize48Weight400 = TextStyle(
    fontSize: 48.sp,
    fontWeight: FontWeight.w400,
  );
}
