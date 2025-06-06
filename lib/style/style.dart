import 'package:flutter/material.dart';

class AppColor {
  static const main = Colors.deepPurple;
  static const bginput = Colors.white;
  static const mediumAqua = Color(0xFFD39FE6);
  static const lightGray = Color(0xFFD3D3D3);
  static const appBar = Color(0xFFD090FF);
  static const black = Colors.black;
  static const clock = Color(0xFF8E53E6);
  static const normal = Color(0xFF4AFF6B);
  static const sobrepeso = Color(0xFFFCA044);
  static const obeso1 = Color(0xFFFC5744);
  static const obeso2 = Color(0xFFFC2C44);
  static const obeso3 = Color(0xFFFC0000);
  static const magro2 = Color(0xFF4444FC);
  static const magro1 = Color(0xFF4488FC);
  static const magro3 = Color(0xFF010CFF);
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
    fontSize: 40,
    fontWeight: FontWeight.w800,
    fontFamily: 'Nunito',
    color: AppColor.main,
  );
}
