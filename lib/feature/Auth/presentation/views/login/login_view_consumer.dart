import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/status/custom_snackbar.dart';
import 'package:halqahquran/core/status/error_snakbar.dart';
import 'package:halqahquran/core/util/app_pref.dart';
import 'package:halqahquran/feature/Auth/ui/cubit/social_auth/social_auth_cubit.dart';
import 'package:halqahquran/feature/Auth/ui/cubit/login/login_cubit.dart';
import 'package:halqahquran/feature/Auth/ui/views/login/login_view_body.dart';
import 'package:halqahquran/feature/home/ui/screen/bootom_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:page_transition/page_transition.dart';

class LoginViewConsumer extends StatelessWidget {
  const LoginViewConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginSuccess) {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.routeName, (route) => false);
              } else if (state is LoginError) {
                showCustomSnackBar(context, state.message, Icons.error, false);
              }
            },
          ),
          BlocListener<SocialAuthCubit, SocialAuthState>(
            listener: (context, state) {
              if (state is SocialAuthSucsses) {
                // Navigator.push(
                //   context,
                //   PageTransition(
                //     type: PageTransitionType.rightToLeft,
                //     duration: const Duration(milliseconds: 400),
                //     child: const BottomNavBar(),
                //   ),
                // );
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeScreen.routeName, (route) => false);
              } else if (state is SocialAuthError) {
                showCustomSnackBar(
                    context, state.errorMassage, Icons.error, false);
              }
            },
          ),
        ],
        child: Builder(
          builder: (context) {
            final stateRrgister = context.watch<LoginCubit>().state;
            final stateSocial = context.watch<SocialAuthCubit>().state;

            return ModalProgressHUD(
              inAsyncCall: stateRrgister is LoginLoading ||
                  stateSocial is SocialAuthLoading,
              child: const LoginViewBody(),
            );
          },
        ));
  }
}
