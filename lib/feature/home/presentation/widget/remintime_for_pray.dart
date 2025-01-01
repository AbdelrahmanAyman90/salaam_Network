import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_function/fun_to_get_date.dart';
import 'package:halqahquran/core/global/global_function/remin_time.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/pray_time/ui/cubit/pray_cubit.dart';

class RemineTime extends StatefulWidget {
  const RemineTime({super.key});

  @override
  State<RemineTime> createState() => _RemineTimeState();
}

class _RemineTimeState extends State<RemineTime> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

//In summary, you don't need to call _startTimer again; the periodic timer itself will keep checking and updating the UI as needed.
  void _startTimer() {
    //This timer is set to trigger its callback every second.
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      final prayCubit = context.read<PrayCubit>();

      // Calculate the remaining time
      final remainingTime = reminTime(
        prayCubit.dateOfNextPray?.entries.first.value ?? "00:00:00",
      );

      // Check if the remaining time is "00:00:00" and call the API
      if (remainingTime == "00:00:00") {
        prayCubit.getPrayTime(getDate(0), "egypt");
      }

      // Trigger a rebuild to update the displayed time
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "الصلاه القادمه بعد",
          style: TextAppStyle.subTittel
              .copyWith(color: Colors.white.withOpacity(0.8), fontSize: 19.sp),
        ),
        BlocBuilder<PrayCubit, PrayState>(
          builder: (context, state) {
            final prayCubit = context.read<PrayCubit>();
            final remainingTime = prayCubit.dateOfNextPray == null
                ? "00:00:00"
                : reminTime(
                    prayCubit.dateOfNextPray!.entries.first.value,
                  );

            return Text(
              remainingTime,
              style: TextAppStyle.normalTittel,
            );
          },
        ),
      ],
    );
  }
}
/**
 * 1. Creating a Timer
There are two main types of timers:

One-time timer: Executes the callback once after a set duration.
Periodic timer: Repeatedly executes the callback at regular intervals.
In your case, the periodic timer is created using Timer.periodic.
 */
/**
 * في بدايه الويدجت عرفت التايمر
 * بعدها عملت فن مهمتها كل ثانيه تنفذ الي جواها 
 * انت بتفحص الي جواها وعلى اساساه هي بتعمل ريبلد لل الويدجت
 * في كل ثانيه ببعتله القيمه من الكيبت بيروح يحسبها
 */