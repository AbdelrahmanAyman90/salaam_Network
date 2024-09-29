import 'package:flutter/material.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/style.dart';

class HadethWidget extends StatelessWidget {
  const HadethWidget(
      {super.key,
      required this.hadethText,
      required this.tittelHadeth,
      required this.desc});
  final String tittelHadeth;
  final String hadethText;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          tittelHadeth,
          style: TextAppStyle.arabicStyle.copyWith(color: Colors.black),
        ),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "نص الحديث",
            style: TextStyle(
                color: Color.fromARGB(255, 229, 100, 8), fontSize: 22),
          ),
        ),
        Center(child: Text(hadethText)),
        const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "شرح فوائد الحديث",
            style: TextStyle(
                color: Color.fromARGB(255, 229, 100, 8), fontSize: 22),
          ),
        ),
        Text(desc)
      ],
    );
  }
}
