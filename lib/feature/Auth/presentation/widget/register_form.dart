import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custom_password_field.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custom_text_field.dart';

class RegisterForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const RegisterForm({
    Key? key,
    required this.formKey,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          FadeInLeft(
            duration: const Duration(milliseconds: 1600),
            child: CustomTextField(
              textInputType: TextInputType.name,
              controllar: nameController,
              hintText: "الاسم",
              icons: const Icon(Icons.person_outline),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'من فضلك ادخل الأسم';
                }
                return null;
              },
            ),
          ),
          AppSize.hight(16),
          FadeInRight(
            duration: const Duration(milliseconds: 1600),
            child: CustomTextField(
              textInputType: TextInputType.emailAddress,
              controllar: emailController,
              hintText: "البريد الالكتروني",
              icons: const Icon(Icons.email_outlined),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'من فضلك ادخل البريد';
                }
                return null;
              },
            ),
          ),
          AppSize.hight(16),
          FadeInLeft(
            duration: const Duration(milliseconds: 1600),
            child: PasswordField(
              passwordController: passwordController,
            ),
          ),
        ],
      ),
    );
  }
}
