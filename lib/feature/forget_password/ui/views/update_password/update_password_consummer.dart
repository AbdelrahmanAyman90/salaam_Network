import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/status/custom_snackbar.dart';
import 'package:halqahquran/core/status/error_snakbar.dart';
import 'package:halqahquran/core/status/show_succses_dialog.dart';
import 'package:halqahquran/feature/Auth/ui/cubit/login/login_cubit.dart';
import 'package:halqahquran/feature/Auth/ui/views/login/login_screen.dart';
import 'package:halqahquran/feature/forget_password/cubit/forget_password_cubit.dart';
import 'package:halqahquran/feature/forget_password/ui/views/update_password/update_password_body.dart';
import 'package:halqahquran/feature/profile/ui/views/profile_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UpdatePasswordConsummer extends StatelessWidget {
  const UpdatePasswordConsummer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is PasswordUpdated) {
          showSuccessDialog(
            context: context,
            onPressed: () {
              Navigator.popUntil(
                context,
                ModalRoute.withName(
                    LoginView.routeName), // Condition to stop popping
              );
// (route) => false: Removes all routes in the stack.
// ModalRoute.withName: Removes all routes until a specific route is found.
            },
          );
        } else if (state is PasswordResetError) {
          showCustomSnackBar(context, state.error, Icons.error, false);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is PasswordResetLoading,
          child: const UpdatePasswordBody(),
        );
      },
    );
  }
}
