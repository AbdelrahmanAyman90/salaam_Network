import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_function/fun_to_convert_string_to_timeofday.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/core/util/app_pref.dart';
import 'package:halqahquran/core/util/const_varible.dart';
import 'package:halqahquran/feature/notfication/local_notfication_helper.dart';

class BuilHeader extends StatefulWidget {
  const BuilHeader(
      {super.key, required this.prayName, required this.prayerTime});
  final PrayerName prayName;
  final String prayerTime;
  @override
  _BuilHeaderState createState() => _BuilHeaderState();
}

class _BuilHeaderState extends State<BuilHeader> {
  late bool isNotificationEnabled;

  @override
  void initState() {
    super.initState();
    isNotificationEnabled = SharedPrefService.getBool(widget.prayName.english);
  }

  void notificationFunction() {
    setState(() {
      isNotificationEnabled = !isNotificationEnabled;
      SharedPrefService.setBool(widget.prayName.english, isNotificationEnabled);

      if (isNotificationEnabled == false) {
        LocalNotificationService.cancelNotification(widget.prayName.hashCode);
      } else {
        LocalNotificationService.showDailySchduledNotification(
            prayerName: widget.prayName.arabic,
            prayerTime: stringToTimeOfDay(widget.prayerTime));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          widget.prayName.arabic,
          style: TextAppStyle.arabicStyle.copyWith(
            color: AppColor.primeColor,
            fontSize: 18.sp,
          ),
        ),
        IconButton(
          onPressed: notificationFunction,
          icon: Icon(
            isNotificationEnabled
                ? Icons.notifications
                : Icons.notifications_none_outlined,
            size: 32,
            color: isNotificationEnabled
                ? AppColor.primeColor // Change to prime color when clicked
                : Colors.grey.withOpacity(.7),
          ),
        ),
      ],
    );
  }
}
