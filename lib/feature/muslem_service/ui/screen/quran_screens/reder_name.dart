import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/global/global_widget/top_page.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/style.dart';
import 'package:halqahquran/feature/muslem_service/cubit/quran_cubit.dart/cubit/quran_cubit.dart';
import 'package:halqahquran/feature/muslem_service/ui/widget/quran_widgets/reder_name_widget.dart';
import 'package:halqahquran/feature/muslem_service/ui/widget/quran_widgets/search_widget.dart';
import 'package:page_transition/page_transition.dart';

class RedarName extends StatelessWidget {
  final int indexSurah;
  final String surahName;
  const RedarName(
      {super.key, required this.indexSurah, required this.surahName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuranCubit()..getRederData(),
      child: SafeScaffold(
        body: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
                child: TopPage(
              nameTittel: "القراء",
            )),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SearchTextField(
                hint: "ادخل اسم القارئ",
              ),
            )),
            BlocBuilder<QuranCubit, QuranState>(
              builder: (context, state) {
                var cubit = BlocProvider.of<QuranCubit>(context);

                String linkAudio = checkIndex((indexSurah + 1)
                    .toString()); //block builder build only when the state changes call 1
//SliverList calls its builder function for every index, resulting in checkIndex being called for each item.call 9 if but
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return RedarNameWedgit(
                          nameReder: cubit.rederDataList[index].name!,
                          link:
                              '${cubit.rederDataList[index].moshaf![0].server!}$linkAudio.mp3',
                          nameSurah: surahName,
                          listOfSurahs: cubit
                              .rederDataList[index].moshaf![0].surahList!
                              .split(','),
                          indexOfSurah: indexSurah);
                    },
                    childCount: cubit.rederDataList.length,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

bool checkIfFound(String indexSurah, List<String> allSurah) {
  log(allSurah.contains(indexSurah).toString());
  return allSurah.contains(indexSurah);
}

String checkIndex(String index) {
  log(index.length.toString());
  if (index.length == 1) {
    return '00${index}';
  } else if (index.length == 2) {
    return '0$index';
  }
  return index;
}
