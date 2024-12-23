import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/feature/Auth/cubit/register/register_cubit.dart';
import 'package:halqahquran/feature/Auth/ui/widget/auth_by_another.dart';
import 'package:halqahquran/feature/Auth/ui/widget/choose_image.dart';

import 'package:halqahquran/feature/Auth/ui/widget/ishave_account_widget.dart';
import 'package:halqahquran/feature/Auth/ui/widget/register_form.dart';
import 'package:halqahquran/feature/Auth/ui/widget/register_vbutton.dart';

class RegisterViewBody extends StatefulWidget {
  const RegisterViewBody({Key? key}) : super(key: key);

  @override
  State<RegisterViewBody> createState() => _RegisterViewBodyState();
}

class _RegisterViewBodyState extends State<RegisterViewBody> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  File? selectedImage;

  void onImagePicked(File image) {
    setState(
      () {
        selectedImage = image;
      },
    );
  }

  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<RegisterCubit>().registerUser(
            name: nameController.text,
            image: selectedImage?.path,
            email: emailController.text,
            password: passwordController.text,
          );
      print("==========================================================");
      print("${emailController.text}");
    } else {
      print("==========================================================");

      print("${emailController.text}");

      print("Form is not valid");
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AppSize.hight(12),
            ImagePickerWidget(
              selectedImage: selectedImage,
              onImagePicked: onImagePicked,
              imageName:
                  "https://static.vecteezy.com/ti/vetor-gratis/p1/26434417-padrao-avatar-perfil-icone-do-social-meios-de-comunicacao-do-utilizador-foto-vetor.jpg",
            ),
            AppSize.hight(24),
            RegisterForm(
              formKey: formKey,
              nameController: nameController,
              emailController: emailController,
              passwordController: passwordController,
            ),
            AppSize.hight(30),
            RegisterButton(
              onPressed: () => submitForm(context),
            ),
            AppSize.hight(20),
            const Text("او يمكنك التسجيل "),
            AppSize.hight(20),
            const AuthByAnotherWidget(),
            AppSize.hight(8),
            IsHaveAccount(
              msg: "لديك حساب بالفعل؟",
              onPressed: () {
                Navigator.pop(context);
              },
              msgAfter: "سجل الان !",
            ),
          ],
        ),
      ),
    );
  }
}
