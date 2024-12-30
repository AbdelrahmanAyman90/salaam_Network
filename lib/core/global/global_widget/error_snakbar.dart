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

void showCustomSnackBar(
    BuildContext context, String message, IconData icon, bool isSuccess) {
  Toastification().show(
      context: context, // Optional if you use ToastificationWrapper
      type: isSuccess ? ToastificationType.success : ToastificationType.error,
      style: ToastificationStyle.minimal,
      description: RichText(
        text: TextSpan(
          text: message,
          style: TextStyles.medium18.copyWith(color: Colors.black),
        ),
      ),
      alignment: Alignment.bottomCenter,
      animationDuration: const Duration(milliseconds: 300),
      icon: Icon(icon, color: isSuccess ? Colors.green : Colors.red),
      showIcon: true, // Show or hide the icon
      progressBarTheme: ProgressIndicatorThemeData(
        color: isSuccess ? Colors.green : Colors.red,
        linearTrackColor: Colors.grey.shade300,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      borderRadius: BorderRadius.circular(12),

      // Progress bar customizations:
      showProgressBar: true, // Enable progress bar

      closeButtonShowType: CloseButtonShowType.always,
      autoCloseDuration: Duration(seconds: 3)
      // Prevent toast from disappearing automatically:
      );
}

SnackBar showSuccsesSnackBar(BuildContext context, String message) {
  return SnackBar(
    content: Text(
      message,
      style: TextStyle(fontSize: 18.sp),
    ),
  );
}
