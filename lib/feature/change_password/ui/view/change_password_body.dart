import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custom_password_field.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custom_text_field.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custtom_button.dart';
import 'package:halqahquran/feature/change_password/ui/cubit/change_password_cubit.dart';
import 'package:halqahquran/feature/forget_password/ui/views/forget_password_screen.dart';
import 'package:page_transition/page_transition.dart';

class ChangePasswordBody extends StatelessWidget {
  ChangePasswordBody({super.key});
  TextEditingController oldPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Form(
        key: formKey,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            "كلمه المرور القديمه",
            style: TextStyles.semiBold18,
          ),
          AppSize.hight(10),
          PasswordField(passwordController: oldPasswordController),
          AppSize.hight(30),
          const Text(
            "كلمه المرور الجديده",
            style: TextStyles.semiBold18,
          ),
          AppSize.hight(10),
          PasswordField(passwordController: newPasswordController),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 400),
                    child: const ForgetPasswordScreen(),
                  ),
                );
              },
              child: const Text(
                "نسيت كلمة المرور؟",
                style: TextStyle(
                  fontSize: 16,
                  color: AppColor.primeColor,
                ),
              ),
            ),
          ),
          AppSize.hight(40),
          CustomButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context.read<ChangePasswordCubit>().changePassword(
                      oldPassword: oldPasswordController.text,
                      newPassword: newPasswordController.text,
                    );
              }
            },
            widgetButton: Text(
              "تغيير كلمه المرور",
              style: TextAppStyle.mainTittel.copyWith(
                fontSize: 22,
                fontWeight: FontWeight.w400,
              ),
            ),
          )
        ]),
      ),
    );
  }
}
