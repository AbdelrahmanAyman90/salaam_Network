import 'package:flutter/material.dart';
import 'package:halqahquran/core/theme/color.dart';

class ArrowButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const ArrowButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18, right: 18, top: 60),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Icon(
              icon,
              color: AppColor.primeColor,
              size: 18,
            ),
          ),
        ),
      ),
    );
  }
}
