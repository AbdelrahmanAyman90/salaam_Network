import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/util/screen_util.dart';

class RepeatZekrOrNotWidget extends StatefulWidget {
  RepeatZekrOrNotWidget(
      {super.key,
      required this.zekr,
      required this.reapet,
      required this.description});
  String zekr;
  int reapet;
  String description;
  @override
  State<RepeatZekrOrNotWidget> createState() => _RepeatZekrOrNotWidgetState();
}

class _RepeatZekrOrNotWidgetState extends State<RepeatZekrOrNotWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: widget.reapet != 0
                  ? AppScreenUtil.getResponsiveHeight(context, .023)
                  : AppScreenUtil.getResponsiveHeight(context, .01)),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.primeColor),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: AppScreenUtil.getResponsiveHeight(context, .017),
                left: 12,
                right: 12,
                bottom: widget.reapet != 0
                    ? AppScreenUtil.getResponsiveHeight(context, .038)
                    : AppScreenUtil.getResponsiveHeight(context, .02),
              ),
              child: Column(
                children: [
                  Text(
                    widget.zekr,
                    style: TextStyle(fontSize: 22.sp),
                  ),
                  Text(
                    widget.description,
                    style: TextStyle(
                        fontSize: 18.sp,
                        color: AppColor.primeColor,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ),
        widget.reapet != 0
            ? Positioned(
                bottom: 0,
                right: AppScreenUtil.getResponsiveWidth(context, .79),
                child: ClipOval(
                  child: Container(
                    color: AppColor
                        .primeColor, // Add your desired background color
                    width: 55.0, // Adjust the width as needed
                    height: 55.0, // Adjust the height as needed
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          widget.reapet--;
                        });
                      },
                      child: Text(
                        widget.reapet.toString(),
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }
}
