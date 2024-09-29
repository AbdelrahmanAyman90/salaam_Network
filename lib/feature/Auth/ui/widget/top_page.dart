import 'package:flutter/material.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/style.dart';

class TopPageContiner extends StatelessWidget {
  const TopPageContiner({super.key, required this.tittal, required this.hight});
  final String tittal;
  final double hight;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .35,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            AppColor.primeColor.withOpacity(.5),
            AppColor.primeColor.withOpacity(.7),
            const Color.fromRGBO(77, 201, 164, 1).withOpacity(.9),
          ], end: Alignment.bottomCenter, begin: Alignment.topCenter),
          borderRadius:
              const BorderRadius.only(bottomLeft: Radius.circular(150))),
      child: Stack(children: [
        Center(
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color.fromARGB(255, 40, 126, 100),
                width: 2.0,
              ),
            ),
            child: ClipOval(
              child: Image.asset(
                "assets/images/Rectangle.jpg",
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned(
          left: hight,
          bottom: 20,
          child: Text(
            tittal,
            style: TextAppStyle.mainTittel,
          ),
        )
      ]),
    );
  }
}
