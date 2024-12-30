import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/profile/ui/cubit/profile_cubit.dart';
import 'package:halqahquran/feature/profile/ui/views/profile_consummer.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: SafeScaffold(
        appBar: AppBar(
          backgroundColor: AppColor.colorAppBar,
          automaticallyImplyLeading: false,
          title: const Text(
            'حسابي',
            style: TextStyles.semiBold22,
            textAlign: TextAlign.end,
          ),
          centerTitle: true,
        ),
        body: const ProfileConsummer(),
      ),
    );
  }
}
