import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_widget/error_snakbar.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/style.dart';
import 'package:halqahquran/feature/Auth/cubit/cubit/auth_cubit.dart';
import 'package:halqahquran/feature/Auth/ui/widget/auth_by_another.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custom_password_field.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custom_text_field.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custtom_button.dart';
import 'package:halqahquran/feature/Auth/ui/widget/ishave_account_widget.dart';
import 'package:halqahquran/feature/Auth/ui/widget/top_page.dart';
import 'package:halqahquran/feature/home/ui/screen/bootom_bar.dart';
import 'package:halqahquran/feature/home/ui/screen/home_body.dart';
import 'package:page_transition/page_transition.dart';

class RegisterScreen extends StatelessWidget {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController namecontrollar = TextEditingController();

  final TextEditingController emialControl = TextEditingController();
  final formKey = GlobalKey<FormState>();
  RegisterScreen({super.key});
  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<AuthCubit>().register(
          emialControl.text, passwordController.text, namecontrollar.text);
      print("Form is valid");
    } else {
      print("Form is not valid");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TopPageContiner(
              tittal: "حساب جديد",
              hight: 260,
            ),
            AppSize.hight(4),
            Text(
              " انشئ حساب !",
              style: TextAppStyle.subTittel.copyWith(fontSize: 25.sp),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      controllar: namecontrollar,
                      msg: "الاسم",
                      icons: const Icon(Icons.email_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك ادخل الأسم';
                        }

                        return null;
                      },
                    ),
                    CustomTextField(
                      controllar: emialControl,
                      msg: "البريد الالكتروني",
                      icons: const Icon(Icons.email_outlined),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'من فضلك ادخل البريد';
                        }

                        return null;
                      },
                    ),
                    PasswordField(
                      passwordController: passwordController,
                    )
                  ],
                ),
              ),
            ),
            AppSize.hight(12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthRegisterSucsses) {
                    Navigator.pushAndRemoveUntil(
                      context,
                      PageTransition(
                        type: PageTransitionType.rightToLeft,
                        duration: const Duration(milliseconds: 800),
                        child: const BottomNavBar(),
                        isIos: true,
                      ),
                      (Route<dynamic> route) =>
                          false, // Removes all previous routes
                    );
                  } else if (state is AuthFaileRegister) {
                    showErrorSnackBar(context, state.errorMassage);
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    onPressed: () => submitForm(context),
                    widgetButton: state is AuthLoading
                        ? const CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : Text(
                            "تسجيل",
                            style: TextAppStyle.mainTittel.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                  );
                },
              ),
            ),
            AppSize.hight(8),
            const Text("او يمكنك التسجيل "),
            AppSize.hight(8),
            const AuthByAnotherWidget(),
            AppSize.hight(8),
            IsHaveAccount(
              msg: "لديك حساب بالفعل ؟",
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
