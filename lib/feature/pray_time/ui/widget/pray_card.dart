import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_function/fun_to_get_date.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/util/const_varible.dart';
import 'package:halqahquran/feature/pray_time/ui/cubit/pray_cubit.dart';
import 'package:halqahquran/core/util/screen_util.dart';
import 'package:halqahquran/feature/pray_time/ui/widget/buid_head_pray_card.dart';
import 'package:halqahquran/feature/pray_time/ui/widget/pray_time_card.dart';

class PrayCard extends StatelessWidget {
  final PrayerName prayName;
  final int index;

  const PrayCard({
    super.key,
    required this.prayName,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<PrayCubit>();
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppScreenUtil.getResponsiveHeight(context, .015),
      ),
      child: BlocBuilder<PrayCubit, PrayState>(
        builder: (context, state) {
          final prayerTime = _getPrayerTime(state);

          return Container(
            decoration: BoxDecoration(
              color: cubit.dateOfNextPray != null &&
                      cubit.dateOfNextPray!.entries.first.key == index &&
                      cubit.currentDate == getDate(0)
                  ? const Color.fromARGB(255, 190, 231, 217)
                  : Colors.white,
              border: Border.all(color: AppColor.primeColor, width: .7),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BuilHeader(
                    prayName: prayName,
                    prayerTime: prayerTime,
                  ),
                  BuildPrayerTime(
                    prayerTime: prayerTime,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  String _getPrayerTime(PrayState state) {
    if (state is PrayLoaded) {
      return state.prayData.timings!.prayerTimes![index].toString();
    } else if (state is PrayLoadingWithPrevious) {
      return state.previousPrayData.timings!.prayerTimes![index].toString();
    }
    return ''; // Default value if no data is available
  }
}
