import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/text_style.dart';

class TopPageContiner extends StatelessWidget {
  const TopPageContiner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeInUp(
            duration: const Duration(milliseconds: 1000),
            child: Text(
              "تسجيل الدخول",
              style: TextStyles.semiBold26
                  .copyWith(color: Colors.white, fontSize: 32), // TextStyle
            ),
          ),
          SizedBox(height: 10),
          FadeInUp(
            duration: const Duration(milliseconds: 1300),
            child: Text(
              "اهلا بعودتك مرة أخرى",
              style: TextStyles.semiBold18
                  .copyWith(color: Colors.white, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
