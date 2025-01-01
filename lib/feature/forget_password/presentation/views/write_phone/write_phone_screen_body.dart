import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/status/custom_snackbar.dart';
import 'package:halqahquran/core/status/error_snakbar.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custom_text_field.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custtom_button.dart';
import 'package:halqahquran/feature/forget_password/cubit/forget_password_cubit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class WritePhoneScreenBody extends StatefulWidget {
  const WritePhoneScreenBody({super.key});

  @override
  State<WritePhoneScreenBody> createState() => _WritePhoneScreenBodyState();
}

class _WritePhoneScreenBodyState extends State<WritePhoneScreenBody> {
  TextEditingController phooneNumber = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(children: [
        AppSize.hight(30),
        const Text(
          'ادخل رقم الجوال لاستعادة كلمة المرور',
          style: TextStyles.medium18,
        ),
        AppSize.hight(10),
        IntlPhoneField(
          decoration: const InputDecoration(
            labelText: 'Phone Number',
            border: OutlineInputBorder(
              borderSide: BorderSide(),
            ),
          ),
          initialCountryCode: 'EG',
          onChanged: (value) {
            phooneNumber.text = value.completeNumber;
          },
        ),
        AppSize.hight(30),
        CustomButton(
          onPressed: () {
            if (phooneNumber.text.isNotEmpty &&
                phooneNumber.text.contains('+20') &&
                phooneNumber.text.length == 13) {
              context
                  .read<ForgetPasswordCubit>()
                  .sendSms(phoneNumber: phooneNumber.text);
            } else {
              showCustomSnackBar(
                  context, "ادخل رقم الجوال صحيح", Icons.error, false);
            }
          },
          widgetButton: Text(
            "ارسل رمز التحقق",
            style: TextStyles.semiBold18.copyWith(color: Colors.white),
          ),
        )
      ]),
    );
  }
}
