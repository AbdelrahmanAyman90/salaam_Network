import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/font_manger.dart';

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

abstract class TextStyles {
  static const TextStyle regular14 = TextStyle(
    fontSize: FontSize.s14,
    fontWeight: FontWeightManager.regular,
  );

  static const TextStyle regular16 =
      TextStyle(fontSize: FontSize.s16, fontWeight: FontWeightManager.regular);

  static const TextStyle regular18 =
      TextStyle(fontSize: FontSize.s18, fontWeight: FontWeightManager.regular);

  static const TextStyle regular26 =
      TextStyle(fontSize: FontSize.s26, fontWeight: FontWeightManager.regular);

  static const TextStyle regular48 =
      TextStyle(fontSize: FontSize.s48, fontWeight: FontWeightManager.regular);

  static const TextStyle medium12 =
      TextStyle(fontSize: FontSize.s12, fontWeight: FontWeightManager.medium);

  static const TextStyle medium14 =
      TextStyle(fontSize: FontSize.s14, fontWeight: FontWeightManager.medium);

  static const TextStyle medium16 =
      TextStyle(fontSize: FontSize.s16, fontWeight: FontWeightManager.medium);

  static const TextStyle medium18 =
      TextStyle(fontSize: FontSize.s18, fontWeight: FontWeightManager.medium);

  static const TextStyle semiBold14 =
      TextStyle(fontSize: FontSize.s14, fontWeight: FontWeightManager.semiBold);

  static const TextStyle semiBold18 =
      TextStyle(fontSize: FontSize.s18, fontWeight: FontWeightManager.semiBold);

  static const TextStyle semiBold22 =
      TextStyle(fontSize: FontSize.s22, fontWeight: FontWeightManager.semiBold);

  static const TextStyle semiBold26 =
      TextStyle(fontSize: FontSize.s26, fontWeight: FontWeightManager.semiBold);

  static const TextStyle bold16 =
      TextStyle(fontSize: FontSize.s16, fontWeight: FontWeightManager.bold);

  static const TextStyle bold18 =
      TextStyle(fontSize: FontSize.s18, fontWeight: FontWeightManager.bold);

  static const TextStyle bold24 =
      TextStyle(fontSize: FontSize.s24, fontWeight: FontWeightManager.bold);
}
