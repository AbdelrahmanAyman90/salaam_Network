import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/global/global_widget/top_page.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/muslem_service/data/model/hadeth_model.dart';
import 'package:halqahquran/feature/muslem_service/ui/widget/count_zekr.dart';
import 'package:halqahquran/feature/muslem_service/ui/widget/hadeth_widget.dart';
import 'package:halqahquran/core/util/screen_util.dart';

class ZekrScreen extends StatelessWidget {
  const ZekrScreen(
      {super.key, required this.iteamListData, required this.tittel});
  final List<dynamic> iteamListData;
  final String tittel;
  @override
  Widget build(BuildContext context) {
    log(iteamListData.first.toString());
    return SafeScaffold(
      body: SingleChildScrollView(
        child: Column(children: [
          TopPage(
            nameTittel: tittel,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppScreenUtil.getResponsiveWidth(context, .03),
              vertical: AppScreenUtil.getResponsiveWidth(context, .05),
            ),
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                if (iteamListData.isNotEmpty &&
                    iteamListData.first is HadehtData) {
                  //!hadeth is diffrence shape
                  return HadethWidget(
                    hadethText: iteamListData[index].hadith,
                    desc: iteamListData[index].description,
                    tittelHadeth: tittel,
                  );
                } else {
                  //!zekr and dua is same
                  return RepeatZekrOrNotWidget(
                    zekr: iteamListData[index].zekr,
                    reapet: iteamListData[index].repeat!,
                    description: iteamListData[index].description,
                  );
                }
              },
              itemCount: iteamListData.length,
            ),
          ),
        ]),
      ),
    );
  }
}
