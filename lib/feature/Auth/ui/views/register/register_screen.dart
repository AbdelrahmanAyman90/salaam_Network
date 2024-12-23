import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/service/get_it_service.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/Auth/cubit/social_auth/social_auth_cubit.dart';
import 'package:halqahquran/feature/Auth/cubit/register/register_cubit.dart';
import 'package:halqahquran/feature/Auth/domain/repos/auth_repo.dart';

import 'package:halqahquran/feature/Auth/ui/views/register/register_view_consumer.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegisterCubit(
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
        appBar: AppBar(
          backgroundColor: Colors.white.withOpacity(0.1),
          leading: GestureDetector(
            child: const Icon(Icons.arrow_back_ios),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            'حساب جديد',
            style: TextStyles.bold18,
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
        ),
        body: const RegisterViewConsumer(),
      ),
    );
  }
}
