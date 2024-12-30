import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_widget/error_snakbar.dart';
import 'package:halqahquran/feature/forget_password/cubit/forget_password_cubit.dart';
import 'package:halqahquran/feature/forget_password/ui/views/verifiy_code_screen.dart';
import 'package:halqahquran/feature/forget_password/ui/views/verify_code_consummer.dart';
import 'package:halqahquran/feature/forget_password/ui/views/write_phone_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class WritePhoneConummer extends StatelessWidget {
  const WritePhoneConummer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is PasswordResetCodeSent) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VerifyCodeConsummer(),
            ),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is PasswordResetLoading,
          child: const WritePhoneScreen(),
        );
      },
    );
  }
}
