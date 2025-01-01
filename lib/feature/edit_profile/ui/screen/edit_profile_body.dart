import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_function/get_user_data.dart';
import 'package:halqahquran/core/status/custom_snackbar.dart';
import 'package:halqahquran/core/status/error_snakbar.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/Auth/ui/widget/choose_image.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custom_password_field.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custtom_button.dart';
import 'package:halqahquran/feature/edit_profile/ui/cubit/edit_profile_cubit.dart';
import 'package:halqahquran/feature/edit_profile/ui/widget/edit_profile_field.dart';

class EditProfileBody extends StatefulWidget {
  const EditProfileBody({super.key});

  @override
  State<EditProfileBody> createState() => _EditProfileBodyState();
}

class _EditProfileBodyState extends State<EditProfileBody> {
  TextEditingController nameControlar = TextEditingController();

  TextEditingController emialControlar = TextEditingController();

  TextEditingController passwordControlar = TextEditingController();

  final formKey = GlobalKey<FormState>();
  File? selectedImage;
  @override
  void dispose() {
    nameControlar.dispose();
    emialControlar.dispose();
    passwordControlar.dispose();
    super.dispose();
  }

  void onImagePicked(File image) {
    setState(
      () {
        selectedImage = image;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is UserUpdateSuccses) {
          FocusScope.of(context).unfocus();
          setState(() {
            passwordControlar.clear();
            selectedImage = null;
            nameControlar.clear();
            emialControlar.clear();
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 8),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                ImagePickerWidget(
                  selectedImage: selectedImage,
                  onImagePicked: onImagePicked,
                  imageName: getUserData().image!.isEmpty
                      ? "https://static.vecteezy.com/ti/vetor-gratis/p1/26434417-padrao-avatar-perfil-icone-do-social-meios-de-comunicacao-do-utilizador-foto-vetor.jpg"
                      : getUserData().image!,
                ),
                AppSize.hight(15),
                EditProfileField(
                  title: "الاسم",
                  controllar: nameControlar,
                  hintText: getUserData().name,
                ),
                AppSize.hight(15),
                EditProfileField(
                  title: "البريد الالكتروني",
                  controllar: emialControlar,
                  hintText: getUserData().email,
                ),
                AppSize.hight(15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        " كلمه المرور",
                        style: TextAppStyle.normalTittel,
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 6),
                        child: PasswordField(
                          passwordController: passwordControlar,
                          color: AppColor.primeColor,
                        )),
                  ],
                ),
                AppSize.hight(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: CustomButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        log("message");
                        log(nameControlar.text);
                        if (selectedImage == null &&
                            nameControlar.text.isEmpty &&
                            emialControlar.text.isEmpty) {
                          showCustomSnackBar(
                              context,
                              "يجب علي الاقل ادخال اسم او بريد الكتروني او صورة",
                              Icons.error,
                              false);
                        } else {
                          context.read<EditProfileCubit>().verifyEmail(
                                newEmail: emialControlar.text.isEmpty
                                    ? null
                                    : emialControlar.text,
                                password: passwordControlar.text,
                                newImage: selectedImage?.path,
                                newName: nameControlar.text.isEmpty
                                    ? null
                                    : nameControlar.text,
                              );
                        }
                      }
                    },
                    widgetButton: Text(
                      "تحقق من البريد الالكتروني",
                      style: TextAppStyle.mainTittel.copyWith(
                        fontSize: 25,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
/**
 * فاضل كدا نزبط التلفون
 * ونزبط لو داس على الزرار عشان يحفظ نزبط الحالات بتاعتها 
 * ولما ندوس على التلات زراير نغير ساعتها الباسورد بطريقه اننا نبعت للايميل
 */