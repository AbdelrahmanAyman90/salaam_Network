import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_widget/error_snakbar.dart';
import 'package:halqahquran/feature/Auth/ui/views/login/login_screen.dart';
import 'package:halqahquran/feature/profile/ui/cubit/profile_cubit.dart';
import 'package:halqahquran/feature/profile/ui/views/profile_screen_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ProfileConsummer extends StatelessWidget {
  const ProfileConsummer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is LogoutSuccess) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginView(),
              ),
              (route) => false);
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
