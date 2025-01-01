import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/status/error_snakbar.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custtom_button.dart';
import 'package:halqahquran/feature/home/ui/screen/bootom_bar.dart';
import 'package:page_transition/page_transition.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback onPressed;

  const RegisterButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed,
      widgetButton: Text(
        "إنشاء حساب جديد",
        style: TextStyles.semiBold18.copyWith(color: Colors.white),
      ),
    );
  }
}
