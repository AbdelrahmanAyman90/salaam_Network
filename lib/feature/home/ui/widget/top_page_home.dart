import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_function/get_user_data.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/text_style.dart';

class TopPageHome extends StatelessWidget {
  const TopPageHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "اهلا, ",
          style: TextAppStyle.subTittel,
        ),
        Text(
          getUserData().name,
          style: TextAppStyle.normalTittel.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.primeColor),
        ),
      ],
    );
  }
}
