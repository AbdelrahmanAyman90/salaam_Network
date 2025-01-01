import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/status/custom_snackbar.dart';
import 'package:halqahquran/core/status/error_snakbar.dart';
import 'package:halqahquran/feature/Auth/presentation/views/login/login_view.dart';
import 'package:halqahquran/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:halqahquran/feature/profile/presentation/views/profile_screen_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ProfileConsummer extends StatelessWidget {
  const ProfileConsummer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.pushAndRemoveUntil(
              context, LoginView.routeName, (route) => false);
        } else if (state is LogoutError) {
          showCustomSnackBar(context, state.errorMassage, Icons.error, false);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is LogoutLoading,
          child: const ProfileScreenBody(),
        );
      },
    );
  }
}
