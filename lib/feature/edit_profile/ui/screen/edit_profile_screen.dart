import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/service/get_it_service.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/Auth/domain/repos/auth_repo.dart';
import 'package:halqahquran/feature/edit_profile/domain/repos/edit_profile_repo.dart';
import 'package:halqahquran/feature/edit_profile/ui/cubit/edit_profile_cubit.dart';
import 'package:halqahquran/feature/edit_profile/ui/screen/edit_profile_body.dart';
import 'package:halqahquran/feature/edit_profile/ui/screen/edit_profile_screen_consummer.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EditProfileCubit(
        editProfileRepo: getIt<EditProfileRepo>(),
        authRepo: getIt<AuthRepo>(),
      ),
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
              ' الملف الشخصي',
              style: TextStyles.bold18,
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
          ),
          body: const EditProfileFieldConsummer()),
    );
  }
}
