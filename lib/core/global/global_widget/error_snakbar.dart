import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/size.dart';

SnackBar showErrorSnackBar(BuildContext context, String message) {
  return SnackBar(
    content: Directionality(
      textDirection: TextDirection.rtl,
      child: Row(
        children: [
          Icon(
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
    ),
    behavior: SnackBarBehavior.floating,
  );
}

void showCustomSnackBar(
    BuildContext context, String message, IconData icon, bool isSuccess) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          Icon(icon, color: Colors.white),
          AppSize.width(12),
          Text(
            message,
            style: TextStyle(fontSize: 18.sp),
          )
        ],
      ),
      backgroundColor:
          isSuccess ? Color.fromARGB(255, 20, 146, 51) : Colors.black,
      behavior: SnackBarBehavior.floating,
    ),
  );
}

SnackBar showSuccsesSnackBar(BuildContext context, String message) {
  return SnackBar(
    content: Directionality(
      textDirection: TextDirection.rtl,
      child: Text(
        message,
        style: TextStyle(fontSize: 18.sp),
      ),
    ),
  );
}
