import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/style.dart';

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
          "Ayman",
          style: TextAppStyle.normalTittel.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.w500,
              color: AppColor.primeColor),
        ),
        // Text(
        //   ' ${DateFormat('yyyy-MM-dd').format(DateTime.now())} ${DateFormat('EEEE').format(DateTime.now())}',
        //   style: TextAppStyle.subTittel.copyWith(fontSize: 16),
        // ),
      ],
    );
  }
}
