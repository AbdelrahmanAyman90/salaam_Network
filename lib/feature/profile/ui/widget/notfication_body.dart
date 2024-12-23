import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/feature/notfication/local_notfication_helper.dart';

class NotficationBody extends StatefulWidget {
  const NotficationBody({super.key});

  @override
  State<NotficationBody> createState() => _NotficationBodyState();
}

class _NotficationBodyState extends State<NotficationBody> {
  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fill,
      child: Switch(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        activeTrackColor: AppColor.primeColor,
        inactiveTrackColor: AppColor.backgroundColor,
        value: LocalNotificationService.isNotificationEnabled(),
        onChanged: (value) async {
          LocalNotificationService.saveNotificationStateInSharedPref(
              value: value);
          if (value == false) {
            await LocalNotificationService.cancelAllNotification();
          } else {
            await LocalNotificationService.reworkNotfication();
          }
          setState(() {});
        },
        activeColor: AppColor.backgroundColor,
      ),
    );
  }
}
