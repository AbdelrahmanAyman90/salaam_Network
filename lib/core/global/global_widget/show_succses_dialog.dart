import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void showSuccessDialog(
    {required BuildContext context, required void Function()? onPressed}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/images/succses.svg', // Ensure this path is correct.
              height: 100,
              width: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'تم حفظ التغيرات بنجاح',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: const Text('نعم'),
          ),
        ],
      );
    },
  );
}
