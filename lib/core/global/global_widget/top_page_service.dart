import 'package:arabic_font/arabic_font.dart';
import 'package:flutter/material.dart';

class TopPageService extends StatelessWidget {
  const TopPageService({super.key, required this.tittelOfService});
  final String tittelOfService;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * .07,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 116, 218, 225).withOpacity(.5),
          Color.fromARGB(255, 98, 187, 235).withOpacity(.7),
          Color.fromARGB(255, 98, 187, 235).withOpacity(.7),
          Color.fromARGB(255, 59, 242, 255).withOpacity(.4),
          const Color.fromRGBO(77, 201, 164, 1).withOpacity(.6),
        ], end: Alignment.centerRight, begin: Alignment.centerLeft),
      ),
      child: Center(
        child: Text(
          tittelOfService,
          style: ArabicTextStyle(
            arabicFont: ArabicFont.arefRuqaa,
            fontSize: 28,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
