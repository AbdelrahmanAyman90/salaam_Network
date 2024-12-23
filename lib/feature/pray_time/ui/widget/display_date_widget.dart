import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/core/theme/text_style.dart';
import 'package:halqahquran/feature/pray_time/ui/cubit/pray_cubit.dart';
import 'package:halqahquran/core/util/screen_util.dart';

class DateDisplay extends StatelessWidget {
  const DateDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppScreenUtil.getResponsiveHeight(context, .028),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.calendar_month_outlined,
            color: Colors.white,
          ),
          BlocBuilder<PrayCubit, PrayState>(
            builder: (context, state) {
              final day = _getDay(state);
              final date = _getDate(state);
              return Column(
                children: [
                  Text(day,
                      style: TextAppStyle.arabicStyle.copyWith(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.normal,
                      )),
                  Directionality(
                    textDirection: TextDirection.ltr,
                    child: Text(
                      date,
                      style: TextStyle(
                        color: Colors.white.withOpacity(.6),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          AppSize.hight(4),
          Row(
            children: [
              Text(
                "Egypt",
                style: TextStyle(color: Colors.white.withOpacity(.6)),
              ),
              const Icon(
                Icons.location_on,
                color: Colors.white,
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getDay(PrayState state) {
    if (state is PrayLoaded) {
      return state.prayData.date!.ar!;
    } else if (state is PrayLoadingWithPrevious) {
      return state.previousPrayData.date!.ar!;
    }
    return ''; // Default value if no data is available
  }

  String _getDate(PrayState state) {
    if (state is PrayLoaded) {
      return state.prayData.date!.readable!;
    } else if (state is PrayLoadingWithPrevious) {
      return state.previousPrayData.date!.readable!;
    }
    return ''; // Default value if no data is available
  }
}
