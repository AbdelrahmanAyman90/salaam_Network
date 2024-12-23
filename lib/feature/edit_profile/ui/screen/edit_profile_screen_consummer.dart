import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:halqahquran/core/global/global_widget/error_snakbar.dart';
import 'package:halqahquran/core/global/global_widget/show_succses_dialog.dart';
import 'package:halqahquran/feature/edit_profile/ui/cubit/edit_profile_cubit.dart';
import 'package:halqahquran/feature/edit_profile/ui/screen/edit_profile_body.dart';
import 'package:halqahquran/feature/edit_profile/ui/screen/edit_profile_screen.dart';
import 'package:halqahquran/feature/home/ui/screen/bootom_bar.dart';
import 'package:halqahquran/feature/profile/ui/views/profile_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class EditProfileFieldConsummer extends StatefulWidget {
  const EditProfileFieldConsummer({super.key});

  @override
  _EditProfileFieldConsummerState createState() =>
      _EditProfileFieldConsummerState();
}

class _EditProfileFieldConsummerState extends State<EditProfileFieldConsummer> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is UserUpdateSuccses) {
          showSuccessDialog(
            context: context,
            onPressed: () {
              Navigator.pop(context);
            },
          );
        }

        if (state is UserVerificatiSuccses && !state.isVerifyed) {
          showCustomSnackBar(
            context,
            "تم ارسال البريد الالكتروني بنجاح",
            Icons.check,
            true,
          );
        } else if (state is UserUpdateFaile) {
          showCustomSnackBar(context, state.errorMassage, Icons.error, false);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is UserUpdateLaoding,
          child: const EditProfileBody(),
        );
      },
    );
  }
}
