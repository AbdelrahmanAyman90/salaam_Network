import 'package:flutter/material.dart';

class AppScreenUtil {
  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getScreenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  static double getResponsiveHeight(BuildContext context, double percentage) {
    return getScreenHeight(context) * percentage;
  }

  static double getResponsiveWidth(BuildContext context, double percentage) {
    return getScreenWidth(context) * percentage;
  }
}
