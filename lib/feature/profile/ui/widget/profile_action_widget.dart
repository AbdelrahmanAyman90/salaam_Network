import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';

class ProfileActionWidget extends StatelessWidget {
  const ProfileActionWidget(
      {super.key,
      required this.tittel,
      required this.icon,
      this.trailing,
      required this.onTapped});
  final String tittel;
  final IconData icon;
  final void Function() onTapped;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      GestureDetector(
        onTap: onTapped,
        child: Row(
          children: [
            Icon(
              icon,
              size: 28,
              color: AppColor.primeColor,
            ),
            AppSize.width(12),
            Text(
              tittel,
              style: TextStyles.medium16.copyWith(color: AppColor.subText2),
            ),
            const Spacer(),
            trailing ??
                Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: AppColor.subText2,
                ),
          ],
        ),
      ),
      AppSize.hight(12),
      const Divider(
        thickness: .8,
      ),
    ]);
  }
}
