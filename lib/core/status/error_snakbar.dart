import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:toastification/toastification.dart';

SnackBar showErrorSnackBar(BuildContext context, String message) {
  return SnackBar(
    content: Row(
      children: [
        const Icon(
          Icons.wifi_off_outlined,
          color: Colors.white,
        ),
        AppSize.width(12),
        Text(
          message,
          style: TextStyle(fontSize: 18.sp),
        ),
      ],
    ),
    behavior: SnackBarBehavior.floating,
  );
}
