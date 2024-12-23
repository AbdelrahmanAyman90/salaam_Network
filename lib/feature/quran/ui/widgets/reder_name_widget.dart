import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_widget/show_toats.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/feature/muslem_service/ui/screen/quran_screens/audio_player_screen.dart';
import 'package:halqahquran/feature/muslem_service/ui/screen/quran_screens/reder_name.dart';
import 'package:just_audio/just_audio.dart';
import 'package:page_transition/page_transition.dart';

class RedarNameWedgit extends StatelessWidget {
  const RedarNameWedgit(
      {super.key,
      required this.nameReder,
      required this.link,
      required this.nameSurah,
      required this.listOfSurahs,
      required this.indexOfSurah});
  final String nameReder;
  final String link;
  final String nameSurah;
  final List<String> listOfSurahs;
  final int indexOfSurah;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: InkWell(
        onTap: () {
          checkIfFound(indexOfSurah.toString(), listOfSurahs)
              ? Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    duration: const Duration(milliseconds: 400),
                    child: AudioPlayScreen(
                      nameSorah: nameSurah,
                      linkAudio: link,
                      rederName: nameReder,
                    ),
                  ))
              : showToats("لم تتم اضافه ${nameSurah} حتى الان");
        },
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
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  nameReder,
                  style: TextStyle(
                      fontSize: 28.sp,
                      color: AppColor.primeColor,
                      fontWeight: FontWeight.bold),
                ),
                Center(
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 32.sp,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
