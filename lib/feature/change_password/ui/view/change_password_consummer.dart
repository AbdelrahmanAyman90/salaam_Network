import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_widget/error_snakbar.dart';
import 'package:halqahquran/feature/change_password/ui/cubit/change_password_cubit.dart';
import 'package:halqahquran/feature/change_password/ui/view/change_password_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ChangePasswordConsummer extends StatelessWidget {
  const ChangePasswordConsummer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccses) {
          showCustomSnackBar(
              context, "تم تغيير كلمة المرور بنجاح", Icons.check, true);
          Navigator.pop(context);
        } else if (state is ChangePasswordError) {
          showCustomSnackBar(context, state.errorMassage, Icons.error, false);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is ChangePasswordLoading,
          child: ChangePasswordBody(),
        );
      },
    );
  }
}
