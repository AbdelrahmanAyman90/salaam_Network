import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/service/get_it_service.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/Auth/ui/cubit/social_auth/social_auth_cubit.dart';
import 'package:halqahquran/feature/Auth/ui/cubit/login/login_cubit.dart';
import 'package:halqahquran/feature/Auth/domain/repos/auth_repo.dart';
import 'package:halqahquran/feature/Auth/ui/views/login/login_view_body.dart';
import 'package:halqahquran/feature/Auth/ui/views/login/login_view_consumer.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginCubit(
            authRepo: getIt<AuthRepo>(),
          ),
        ),
        BlocProvider(
          create: (context) => SocialAuthCubit(
            authRepo: getIt<AuthRepo>(),
          ),
        ),
      ],
      child: SafeScaffold(
        body: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  AppColor.primeColor,
                  AppColor.primeColor.withOpacity(.8),
                  AppColor.primeColor.withOpacity(.4),
                ],
              ),
            ),
            child: const LoginViewConsumer()),
      ),
    );
  }
}
