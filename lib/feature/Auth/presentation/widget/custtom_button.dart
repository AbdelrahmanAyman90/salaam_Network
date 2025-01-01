import 'package:flutter/material.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/text_style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.onPressed, required this.widgetButton});
  final void Function()? onPressed;
  final Widget widgetButton;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColor.primeColor,
      ),
      child: MaterialButton(onPressed: onPressed, child: widgetButton),
    );
  }
}
