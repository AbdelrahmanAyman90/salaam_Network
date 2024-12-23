import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_widget/error_snakbar.dart';
import 'package:halqahquran/feature/forget_password/cubit/forget_password_cubit.dart';
import 'package:halqahquran/feature/forget_password/ui/views/update_password_scree.dart';
import 'package:halqahquran/feature/forget_password/ui/views/verifiy_code_screen.dart';

class VerifyCodeConsummer extends StatelessWidget {
  const VerifyCodeConsummer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is PasswordResetVerified) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const UpdatePasswordScreen()),
          );
        } else if (state is PasswordResetError) {
          showCustomSnackBar(context, state.error, Icons.error, false);
        }
      },
      builder: (context, state) {
        return const VerifyCodePage();
      },
    );
  }
}
