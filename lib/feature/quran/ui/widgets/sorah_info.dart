import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_function/check_internet.dart';
import 'package:halqahquran/core/global/global_function/convert_englishnum_to_arabic.dart';
import 'package:halqahquran/core/routes/argumnt_class.dart';
import 'package:halqahquran/core/status/show_toats.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/feature/quran/ui/quran_cubit.dart/cubit/quran_cubit.dart';
import 'package:halqahquran/feature/quran/ui/screen/reder_name_screen.dart';
import 'package:halqahquran/feature/quran/ui/widgets/quran_page.dart';
import 'package:halqahquran/feature/quran/ui/widgets/sorah_list.dart';
import 'package:page_transition/page_transition.dart';

class SorahInfoWidget extends StatelessWidget {
  final int index;
  final String nameArabic;
  final String sorahType;
  const SorahInfoWidget(
      {super.key,
      required this.index,
      required this.nameArabic,
      required this.sorahType});

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
            // Navigator.push(
            //   context,
            //   PageTransition(
            //     type: PageTransitionType.rightToLeft,
            //     duration: const Duration(milliseconds: 400),
            //     child: QuranImageScreen(
            //       numberPage:
            //           context.read<QuranCubit>().quranDataList[index].initPage!,
            //     ),
            //   ),
            // );
            Navigator.pushNamed(context, QuranImageScreen.routeName,
                arguments: QuranImageScreenArgumnt(
                  numberPage:
                      context.read<QuranCubit>().quranDataList[index].initPage!,
                ));
          },
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\u06DD${convertToArabicNumber((index + 1).toString())}',
                  style: TextStyle(
                      fontSize: 24.sp,
                      color: AppColor.primeColor,
                      fontFamily: 'Amiri Quran'),
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
                      sorahType,
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
                        ?
                        //  Navigator.push(
                        //     context,
                        //     PageTransition(
                        //       type: PageTransitionType.rightToLeft,
                        //       duration: const Duration(milliseconds: 400),
                        //       child: RederNameScreen(
                        //         indexSurah: index,
                        //         surahName: nameArabic,
                        //       ),
                        //     ),
                        //   )

                        Navigator.pushNamed(
                            context,
                            RederNameScreen.routeName,
                            arguments: RederNameScreenArgument(
                              indexSurah: index,
                              surahName: nameArabic,
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
