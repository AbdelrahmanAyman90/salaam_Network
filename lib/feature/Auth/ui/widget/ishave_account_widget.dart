import 'package:flutter/material.dart';
import 'package:halqahquran/core/theme/color.dart';

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
          style: TextStyle(fontSize: 16),
        ),
        TextButton(
            onPressed: onPressed,
            child: Text(
              msgAfter,
              style: TextStyle(color: AppColor.primeColor, fontSize: 17),
            ))
      ],
    );
  }
}
