import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custom_text_field.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custtom_button.dart';
import 'package:halqahquran/feature/forget_password/cubit/forget_password_cubit.dart';

class WritePhoneScreen extends StatefulWidget {
  const WritePhoneScreen({super.key});

  @override
  State<WritePhoneScreen> createState() => _WritePhoneScreenState();
}

class _WritePhoneScreenState extends State<WritePhoneScreen> {
  TextEditingController phooneNumber = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.1),
        leading: GestureDetector(
          child: const Icon(Icons.arrow_back_ios),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'استعادة كلمة المرور',
          style: TextStyles.bold18,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(children: [
          AppSize.hight(30),
          const Text(
            'ادخل رقم الجوال لاستعادة كلمة المرور',
            style: TextStyles.medium18,
          ),
          AppSize.hight(10),
          Form(
            key: formKey,
            child: CustomTextField(
              textInputType: TextInputType.phone,
              controllar: phooneNumber,
              hintText: "ادخل رقم الجوال",
              icons: const Icon(Icons.phone_outlined),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'من فضلك ادخل رقم الجوال';
                }
                if (value.length < 10) {
                  return 'ادخل رقم الجوال صحيح';
                }
                if (!value.contains('+20')) {
                  return '(لا تنسى كتابه(+20';
                }
                return null;
              },
            ),
          ),
          AppSize.hight(30),
          CustomButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                context
                    .read<ForgetPasswordCubit>()
                    .sendSms(phoneNumber: phooneNumber.text);
              }
            },
            widgetButton: Text(
              "ارسل رمز التحقق",
              style: TextStyles.semiBold18.copyWith(color: Colors.white),
            ),
          )
        ]),
      ),
    );
  }
}
