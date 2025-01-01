import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/status/custom_snackbar.dart';
import 'package:halqahquran/core/status/error_snakbar.dart';
import 'package:halqahquran/feature/Auth/ui/cubit/social_auth/social_auth_cubit.dart';
import 'package:halqahquran/feature/Auth/ui/cubit/register/register_cubit.dart';
import 'package:halqahquran/feature/Auth/ui/views/register/register_view_body.dart';
import 'package:halqahquran/feature/home/ui/screen/bootom_bar.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:page_transition/page_transition.dart';

class RegisterViewConsumer extends StatelessWidget {
  const RegisterViewConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          // Listen to RegisterCubit states
          BlocListener<RegisterCubit, RegisterState>(
            listener: (context, state) {
              if (state is RegisterSuccess) {
                // showCustomSnackBar(
                //     context, "Registration successful!", Icons.done, true);
                // Uncomment and use navigation if required
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
              } else if (state is RegisterError) {
                showCustomSnackBar(context, state.message, Icons.error, false);
              }
            },
          ),
          // Listen to SocialAuthCubit states
          BlocListener<SocialAuthCubit, SocialAuthState>(
            listener: (context, state) {
              if (state is SocialAuthSucsses) {
                // showCustomSnackBar(context, "Social authentication successful!",
                //     Icons.done, true);
                // Uncomment and use navigation if required
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
            final stateRrgister = context.watch<RegisterCubit>().state;
            final stateSocial = context.watch<SocialAuthCubit>().state;

            return ModalProgressHUD(
              inAsyncCall: stateRrgister is RegisterLoading ||
                  stateSocial is SocialAuthLoading,
              child: const RegisterViewBody(),
            );
          },
        ));
  }
}
