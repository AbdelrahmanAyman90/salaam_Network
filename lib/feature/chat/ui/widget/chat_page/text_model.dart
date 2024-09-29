import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/style.dart';
import 'package:halqahquran/util/screen_util.dart';

class TextModelWidgetChat extends StatelessWidget {
  final String massage;
  final bool isSender;
  final bool seen;
  final String time;
  const TextModelWidgetChat({
    super.key,
    required this.isSender,
    required this.massage,
    required this.seen,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSize.hight(10),
        Row(
          mainAxisAlignment:
              isSender ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Container(
                constraints: BoxConstraints(
                  maxWidth:
                      MediaQuery.of(context).size.width * 0.5, // Max width 50%
                  // Set a minimum width to allow short messages to take normal width
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                margin: isSender
                    ? const EdgeInsets.only(right: 10)
                    : const EdgeInsets.only(left: 10),
                decoration: isSender
                    ? BoxDecoration(
                        color: AppColor.primeColor.withOpacity(.5),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r),
                            bottomLeft: Radius.circular(30.r)))
                    : BoxDecoration(
                        color: Colors.grey.withOpacity(.3),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.r),
                            topRight: Radius.circular(30.r),
                            bottomRight: Radius.circular(30.r))),
                child: Column(
                  children: [
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     isSender
                    //         ? const SizedBox()
                    //         : Text(
                    //             userNmae,
                    //             style: TextAppStyle.normalTittel.copyWith(
                    //                 color:
                    //                     const Color.fromARGB(255, 7, 67, 135),
                    //                 fontWeight: FontWeight.bold),
                    //           ),
                    //   ],
                    // ),
                    Text(
                      massage,
                      style: TextAppStyle.normalTittel,
                    ),
                    Row(
                      // Use min to size based on content

                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          time,
                          style: TextAppStyle.subTittel.copyWith(fontSize: 14),
                        ),
                        isSender
                            ? Icon(
                                Icons.done_all_outlined,
                                color: seen ? Colors.lightBlue : Colors.grey,
                              )
                            : SizedBox(),
                      ],
                    )
                  ],
                ))
          ],
        ),
      ],
    );
  }
}
