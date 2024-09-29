import 'dart:developer';

import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_function/check_internet.dart';
import 'package:halqahquran/core/global/global_widget/show_toats.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/feature/muslem_service/cubit/quran_cubit.dart/cubit/quran_cubit.dart';
import 'package:halqahquran/feature/muslem_service/ui/screen/quran_screens/reder_name.dart';
import 'package:halqahquran/feature/muslem_service/ui/widget/quran_widgets/quran_page.dart';
import 'package:halqahquran/util/screen_util.dart';
import 'package:page_transition/page_transition.dart';

class SurahList extends StatelessWidget {
  const SurahList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppScreenUtil.getScreenHeight(context) - 270.h,
      width: double.infinity,
      child: BlocBuilder<QuranCubit, QuranState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<QuranCubit>(context);
          return ListView.builder(
            itemCount: cubit.quranDataList.length, //todo
            itemBuilder: (context, index) {
              return SorahContinerWedgit(
                index: index,
                nameArabic: cubit.quranDataList[index].name!,
                nameEnglish: cubit.quranDataList[index].revelationType!,
              );
            },
          );
        },
      ),
    );
  }
}

String convertToArabicNumber(String input) {
  const westernToArabicDigits = {
    '0': '٠',
    '1': '١',
    '2': '٢',
    '3': '٣',
    '4': '٤',
    '5': '٥',
    '6': '٦',
    '7': '٧',
    '8': '٨',
    '9': '٩',
  };

  return input.split('').map((char) {
    return westernToArabicDigits[char] ?? char;
  }).join('');
}

class SorahContinerWedgit extends StatelessWidget {
  final int index;
  final String nameArabic;
  final String nameEnglish;
  const SorahContinerWedgit(
      {super.key,
      required this.index,
      required this.nameArabic,
      required this.nameEnglish});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      child: Container(
        height: 70.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: const [
            BoxShadow(
                color: Color.fromARGB(255, 80, 113, 103),
                blurRadius: 5,
                offset: Offset(0, 1))
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                duration: const Duration(milliseconds: 400),
                child: QuranImageScreen(
                  n: context
                      .read<QuranCubit>()
                      .quranDataList[index]
                      .ayahs![0]
                      .page
                      .toString(),
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\u06DD${convertToArabicNumber((index + 1).toString())}',
                  style: TextStyle(fontSize: 28.sp, color: AppColor.primeColor),
                ),
                AppSize.width(8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      nameArabic,
                      style: ArabicTextStyle(
                        arabicFont: ArabicFont.avenirArabic,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 57, 56, 56),
                      ),
                    ),
                    Text(
                      nameEnglish,
                      style: TextStyle(
                          color: const Color.fromARGB(255, 7, 67, 135),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const Spacer(),
                InkWell(
                  onTap: () async {
                    await checkInternetConnection()
                        ? Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.rightToLeft,
                              duration: const Duration(milliseconds: 400),
                              child: RedarName(
                                indexSurah: index,
                                surahName: nameArabic,
                              ),
                            ),
                          )
                        : showToats("تاكد من الاتصال بالانترنت ثم اعد الضغط");
                  },
                  child: Container(
                    width: 100.h,
                    height: 50.w,
                    decoration: BoxDecoration(
                        color: AppColor.primeColor,
                        border: Border.all(color: AppColor.primeColor),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                        ),
                        AppSize.width(2),
                        const Text(
                          "صوت",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
