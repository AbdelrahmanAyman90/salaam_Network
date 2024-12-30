import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/global/global_widget/top_page_service.dart';

import 'package:halqahquran/feature/muslem_service/ui/widget/iteam_service_widget.dart';
import 'package:halqahquran/core/util/screen_util.dart';

class ReadZekrAndHadethScreen extends StatelessWidget {
  const ReadZekrAndHadethScreen(
      {super.key, required this.serviceListData, required this.tittel});
  final List<dynamic> serviceListData;
  final String tittel;
  @override
  Widget build(BuildContext context) {
    return SafeScaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TopPageService(
              tittelOfService: tittel,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppScreenUtil.getResponsiveHeight(context, .02),
                horizontal: AppScreenUtil.getResponsiveWidth(context, .02),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return SingelIteamServiceWidget(
                    iteamData: serviceListData[index],
                  );
                },
                itemCount: serviceListData.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}
