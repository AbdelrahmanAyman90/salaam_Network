import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/service/get_it_service.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/change_password/domain/change_password_repo.dart';
import 'package:halqahquran/feature/change_password/ui/cubit/change_password_cubit.dart';
import 'package:halqahquran/feature/change_password/ui/view/change_password_consummer.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});
  static const routeName = 'ChangePasswordScreen';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordCubit(
        changePasswordRepo: getIt<ChangePasswordRepo>(),
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
              'تغيير كلمة المرور',
              style: TextStyles.bold18,
              textAlign: TextAlign.center,
            ),
            centerTitle: true,
          ),
          body: const ChangePasswordConsummer()),
    );
  }
}
