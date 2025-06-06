import 'package:flutter/material.dart';

class AppColor {
  static const main = Colors.deepPurple;
  static const bginput = Colors.white;
  static const mediumAqua = Color(0xFFD39FE6);
  static const lightGray = Color(0xFFD3D3D3);
  static const black = Colors.black;
  static const clock = Color(0xFF8E53E6);
}

class AppTextStyles {
  static const clockText = TextStyle(
    fontSize: 70,
    fontWeight: FontWeight.bold,
    fontFamily: 'Nunito',
    color: AppColor.lightGray,
  );

  static const buttonText = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    fontFamily: 'Nunito',
    color: AppColor.bginput,
  );

  static const register = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    fontFamily: 'Nunito',
    color: AppColor.main,
  );

  static const titler = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w800,
    fontFamily: 'Nunito',
    color: AppColor.main,
  );
}
