import 'package:flutter/material.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/text_style.dart';

class IsHaveAccount extends StatelessWidget {
  const IsHaveAccount(
      {super.key,
      required this.msg,
      required this.onPressed,
      required this.msgAfter});
  final String msg;
  final void Function() onPressed;
  final String msgAfter;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          msg,
          style: TextStyles.semiBold14.copyWith(
            fontSize: 16,
          ),
        ),
        TextButton(
            onPressed: onPressed,
            child: Text(
              msgAfter,
              style: TextStyles.semiBold18.copyWith(color: AppColor.primeColor),
            ))
      ],
    );
  }
}
