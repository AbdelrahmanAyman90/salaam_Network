import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_widget/error_snakbar.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/feature/Auth/ui/cubit/login/login_cubit.dart';
import 'package:halqahquran/feature/Auth/ui/views/login/login_screen.dart';
import 'package:halqahquran/feature/Auth/ui/views/register/register_screen.dart';
import 'package:halqahquran/feature/Auth/ui/widget/auth_by_another.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custom_password_field.dart';
import 'package:halqahquran/feature/Auth/ui/widget/custom_text_field.dart';
import 'package:halqahquran/feature/Auth/ui/widget/ishave_account_widget.dart';
import 'package:halqahquran/feature/Auth/ui/widget/login_button.dart';
import 'package:halqahquran/feature/Auth/ui/widget/top_page.dart';
import 'package:halqahquran/feature/forget_password/ui/views/forget_password_screen.dart';
import 'package:page_transition/page_transition.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  @override
  void dispose() {
    passwordController.dispose();
    emailController.dispose();
    super.dispose();
  }

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      context.read<LoginCubit>().loginUser(
          email: emailController.text, password: passwordController.text);
    } else {
      showCustomSnackBar(
          context, "من فضلك أكمل الحقول المطلوبة.", Icons.error, false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppSize.hight(40),
              const TopPageContiner(),
              AppSize.hight(20),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 50),
                          FadeInLeft(
                            duration: const Duration(milliseconds: 1400),
                            child: CustomTextField(
                              textInputType: TextInputType.emailAddress,
                              controllar: emailController,
                              hintText: "البريد الإلكتروني",
                              icons: const Icon(Icons.email_outlined),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'من فضلك أدخل البريد الإلكتروني.';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(height: 16),
                          FadeInRight(
                            duration: const Duration(milliseconds: 1400),
                            child: PasswordField(
                                passwordController: passwordController),
                          ),
                          const SizedBox(height: 8),
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
                          const SizedBox(height: 12),
                          LoginButton(
                            onPressed: () => submitForm(context),
                          ),
                          const SizedBox(height: 12),
                          const Text("أو يمكنك الدخول عبر"),
                          const SizedBox(height: 12),
                          const AuthByAnotherWidget(),
                          AppSize.hight(8),
                          IsHaveAccount(
                            msg: "ليس لديك حساب ؟",
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.rightToLeft,
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    child: const RegisterView(),
                                    childCurrent: const LoginView(),
                                    isIos: true),
                              );
                            },
                            msgAfter: " انشئ حساب الان !",
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
