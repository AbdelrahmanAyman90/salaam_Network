import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/feature/muslem_service/cubit/quran_cubit.dart/cubit/quran_cubit.dart';

import 'package:halqahquran/feature/muslem_service/ui/widget/quran_widgets/sorah_list.dart';
import 'package:halqahquran/feature/muslem_service/ui/widget/quran_widgets/stop_read.dart';

class QuranScreen extends StatelessWidget {
  const QuranScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranCubit()..getQuranData(),
      child: SafeScaffold(
          body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
        child: Column(
          children: [
            const StopReadCard(),
            AppSize.hight(20),
            const SurahList()
          ],
        ),
      )),
    );
  }
}
