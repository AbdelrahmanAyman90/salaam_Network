import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_function/fun_to_convert_hour.dart';
import 'package:halqahquran/feature/pray_time/ui/cubit/pray_cubit.dart';

class BuildPrayerTime extends StatelessWidget {
  const BuildPrayerTime({super.key, required this.prayerTime});
  final String prayerTime;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.access_time,
          size: 25,
        ),
        const SizedBox(width: 8),
        Text(
          convertToArabicAmPm(prayerTime),
          style: TextStyle(fontSize: 19.sp),
        )
      ],
    );
  }
}
