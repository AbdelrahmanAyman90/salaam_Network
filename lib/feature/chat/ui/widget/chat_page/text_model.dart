import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';

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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text widget will dynamically size based on content
                  Text(
                    massage,
                    style: TextAppStyle.normalTittel,
                    softWrap: true, // Ensure text wraps within the container
                    overflow: TextOverflow
                        .ellipsis, // Add ellipsis if the text is too long
                  ),
                  // Align the time and status icon to the end (right side)
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .end, // Align children to the end (right side)
                    children: [
                      Text(
                        time,
                        style: TextAppStyle.subTittel.copyWith(fontSize: 14),
                      ),
                      if (isSender)
                        Icon(
                          Icons.done_all_outlined,
                          color: seen ? Colors.lightBlue : Colors.grey,
                        ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
