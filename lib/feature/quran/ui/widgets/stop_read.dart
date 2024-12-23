import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/core/util/screen_util.dart';

class StopReadCard extends StatelessWidget {
  const StopReadCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: AppScreenUtil.getResponsiveHeight(context, .25),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColor.primeColor, AppColor.primeColor.withOpacity(.4)],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 14,
            bottom: 14,
            right: AppScreenUtil.getResponsiveHeight(context, .017),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "القراه من حيث توقفت",
                    style: TextAppStyle.mainTittel.copyWith(fontSize: 20.sp),
                  ),
                  AppSize.hight(5),
                  RichText(
                    text: TextSpan(
                      text: 'توقفت  عند ',
                      style: TextStyle(fontSize: 22.sp),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' الزمر',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 7, 67, 135),
                              fontSize: 20.sp,
                            )),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'صفحه ',
                      style: const TextStyle(fontSize: 22),
                      children: <TextSpan>[
                        TextSpan(
                            text: '512',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(255, 7, 67, 135),
                              fontSize: 18.sp,
                            )),
                      ],
                    ),
                  ),
                  Container(
                      width: AppScreenUtil.getResponsiveWidth(context, .45),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "متابعه",
                            style: TextStyle(
                                color: const Color.fromARGB(255, 7, 67, 135),
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold),
                          )))
                ],
              ),
              Image.asset(
                "assets/images/Rectangle4.png",
                width: 140,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
