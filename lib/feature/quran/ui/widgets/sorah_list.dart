import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:halqahquran/feature/quran/ui/quran_cubit.dart/cubit/quran_cubit.dart';
import 'package:halqahquran/core/util/screen_util.dart';
import 'package:halqahquran/feature/quran/ui/widgets/sorah_info.dart';

class SurahList extends StatelessWidget {
  const SurahList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppScreenUtil.getScreenHeight(context) - 270.h,
      width: double.infinity,
      child: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<QuranCubit>(context);
          return ListView.builder(
            itemCount: cubit.quranDataList.length, //todo
            itemBuilder: (context, index) {
              return SorahInfoWidget(
                index: index,
                nameArabic: cubit.quranDataList[index].name!,
                sorahType: cubit.quranDataList[index].revelationType!,
              );
            },
          );
        },
      ),
    );
  }
}
