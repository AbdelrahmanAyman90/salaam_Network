import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/status/error_snakbar.dart';
import 'package:halqahquran/feature/forget_password/cubit/forget_password_cubit.dart';
import 'package:halqahquran/feature/forget_password/ui/views/verifiy_code/verify_code_consummer.dart';
import 'package:halqahquran/feature/forget_password/ui/views/verifiy_code/verify_code_screen.dart';
import 'package:halqahquran/feature/forget_password/ui/views/write_phone/write_phone_screen_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class WritePhoneConummer extends StatelessWidget {
  const WritePhoneConummer({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is PasswordResetCodeSent) {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => const VerifyCodeScreen(),
          //   ),
          // );

          Navigator.pushNamed(
            context,
            VerifyCodeScreen.routeName,
            arguments: BlocProvider.of<ForgetPasswordCubit>(context),
          );
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is PasswordResetLoading,
          child: const WritePhoneScreenBody(),
        );
      },
    );
  }
}
