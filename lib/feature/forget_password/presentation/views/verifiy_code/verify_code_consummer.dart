import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/status/custom_snackbar.dart';
import 'package:halqahquran/core/status/error_snakbar.dart';
import 'package:halqahquran/feature/forget_password/cubit/forget_password_cubit.dart';
import 'package:halqahquran/feature/forget_password/ui/views/update_password/update_password_body.dart';
import 'package:halqahquran/feature/forget_password/ui/views/update_password/update_password_screen.dart';
import 'package:halqahquran/feature/forget_password/ui/views/verifiy_code/verifiy_code_screen_body.dart';

class VerifyCodeConsummer extends StatelessWidget {
  const VerifyCodeConsummer({super.key});

  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is PasswordResetVerified) {
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => const UpdatePasswordView()),k
          // );
          Navigator.pushNamed(context, UpdatePasswordView.routeName,
              arguments: BlocProvider.of<ForgetPasswordCubit>(context));
        } else if (state is PasswordResetError) {
          log(state.error);
          showCustomSnackBar(context, state.error, Icons.error, false);
        }
      },
      builder: (context, state) {
        return const VerifyCodeScreenBody();
      },
    );
  }
}
