import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:halqahquran/core/theme/color.dart';

class TextAppStyle {
  static TextStyle mainTittel = const TextStyle(
      fontSize: 25,
      fontWeight: FontWeight.bold,
      color: Color.fromARGB(255, 255, 255, 255),
      fontFamily: "Lexend");
  static TextStyle subTittel = const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.normal,
      color: AppColor.subText,
      fontFamily: "Lexend");
  static TextStyle normalTittel = const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w400,
      color: Color.fromARGB(255, 0, 0, 0),
      fontFamily: "Lexend");
  static TextStyle arabicStyle = const ArabicTextStyle(
    arabicFont: ArabicFont.lemonada,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}
