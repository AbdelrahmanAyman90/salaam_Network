import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_widget/error_snakbar.dart';
import 'package:halqahquran/core/global/global_widget/show_succses_dialog.dart';
import 'package:halqahquran/feature/forget_password/cubit/forget_password_cubit.dart';
import 'package:halqahquran/feature/forget_password/ui/views/update_password_body.dart';
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
              Navigator.pop(context);
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
