import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/text_style.dart';

class TopPage extends StatelessWidget {
  final String nameTittel;
  const TopPage({super.key, required this.nameTittel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.primeColor.withOpacity(.15),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            Text(
              nameTittel,
              style: TextAppStyle.arabicStyle
                  .copyWith(color: Colors.black, fontSize: 18.sp),
            ),
          ],
        ),
      ),
    );
  }
}
