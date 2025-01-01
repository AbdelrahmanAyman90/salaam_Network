import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/util/asset_app.dart';
import 'package:halqahquran/feature/home/ui/widget/nextprayname_widget.dart';
import 'package:halqahquran/feature/home/ui/widget/remintime_for_pray.dart';
import 'package:halqahquran/core/util/screen_util.dart';

class NextPrayCard extends StatelessWidget {
  const NextPrayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: Container(
        height: AppScreenUtil.getResponsiveHeight(context, .2),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primeColor, AppColor.primeColor.withOpacity(.4)],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 14,
            horizontal: AppScreenUtil.getResponsiveHeight(context, .01),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const NextPrayNmaeAndTime(),
                  AppSize.hight(16),
                  const RemineTime()
                ],
              ),
              Image.asset(
                AssetApp.massgedImage,
                width: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
