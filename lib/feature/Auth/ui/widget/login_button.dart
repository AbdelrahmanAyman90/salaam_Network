import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_widget/error_snakbar.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custtom_button.dart';
import 'package:halqahquran/feature/home/ui/screen/bootom_bar.dart';
import 'package:page_transition/page_transition.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback onPressed;

  const LoginButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed,
      widgetButton: Text(
        "تسجيل الدخول",
        style: TextStyles.semiBold18.copyWith(color: Colors.white),
      ),
    );
  }
}
