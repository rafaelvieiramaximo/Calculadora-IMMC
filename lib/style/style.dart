import 'package:flutter/material.dart';

class AppColor {
  static const main = Colors.deepPurple;
  static const bginput = Colors.white;
  static const mediumAqua = Color(0xFF66CDAA);
}

class AppTextStyles {
  static const clockText = TextStyle(
    fontSize: 48,
    fontWeight: FontWeight.bold,
    fontFamily: 'Nunito',
    color: AppColor.main,
  );

  static const buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: 'Nunito',
    color: AppColor.bginput,
  );
}
