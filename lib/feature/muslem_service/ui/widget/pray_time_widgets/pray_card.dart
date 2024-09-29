import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_function/fun_to_convert_hour.dart';
import 'package:halqahquran/core/global/global_function/fun_to_get_date.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/style.dart';
import 'package:halqahquran/feature/home/cubit/cubit/pray_cubit.dart';
import 'package:halqahquran/util/screen_util.dart';

class PrayCard extends StatelessWidget {
  final String prayName;
  final int index;

  const PrayCard({
    super.key,
    required this.prayName,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppScreenUtil.getResponsiveHeight(context, .015),
      ),
      child: BlocBuilder<PrayCubit, PrayState>(
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              color: context.read<PrayCubit>().dateOfNextPray != null &&
                      context
                              .read<PrayCubit>()
                              .dateOfNextPray!
                              .entries
                              .first
                              .key ==
                          index &&
                      context.read<PrayCubit>().currentDate == getDate(0)
                  ? Color.fromARGB(255, 190, 231, 217)
                  : Colors.white,
              border: Border.all(color: AppColor.primeColor, width: .7),
              borderRadius: const BorderRadius.all(Radius.circular(12)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  _buildPrayerTime(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          prayName,
          style: TextAppStyle.arabicStyle.copyWith(
            color: AppColor.primeColor,
            fontSize: 18.sp,
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.notifications_none_outlined,
            size: 32,
            color: Colors.grey.withOpacity(.7),
          ),
        ),
      ],
    );
  }

  Widget _buildPrayerTime(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.access_time,
          size: 25,
        ),
        const SizedBox(width: 8),
        BlocBuilder<PrayCubit, PrayState>(
          builder: (context, state) {
            final prayerTime = _getPrayerTime(state);
            return Text(
              convertToArabicAmPm(prayerTime),
              style: TextStyle(fontSize: 19.sp),
            );
          },
        ),
      ],
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
