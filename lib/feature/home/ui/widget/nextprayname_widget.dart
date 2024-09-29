import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_function/fun_to_convert_hour.dart';
import 'package:halqahquran/core/global/global_widget/error_snakbar.dart';
import 'package:halqahquran/core/theme/style.dart';
import 'package:halqahquran/feature/home/cubit/cubit/pray_cubit.dart';
import 'package:halqahquran/util/const_varible.dart';

class NextPrayNmaeAndTime extends StatelessWidget {
  const NextPrayNmaeAndTime({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<PrayCubit, PrayState>(
      listener: (context, state) {
        if (state is PrayError) {
          ScaffoldMessenger.of(context).showSnackBar(
              showErrorSnackBar(context, "لايوجد انترنت لعرض الصلاه القادمه"));
        }
      },
      child: BlocBuilder<PrayCubit, PrayState>(
        builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "الصلاه القادمه",
                style: TextAppStyle.subTittel.copyWith(
                  color: Colors.white.withOpacity(0.8),
                ),
              ),
              const SizedBox(height: 8),
              state is PrayLoading || state is PrayError
                  ? const SizedBox(
                      height: 20,
                    )
                  : Text(
                      context.read<PrayCubit>().dateOfNextPray == null
                          ? "انتهت صلاوات اليوم"
                          : "${praysName[context.read<PrayCubit>().dateOfNextPray!.entries.first.key]} ${convertToArabicAmPm(context.read<PrayCubit>().dateOfNextPray!.entries.first.value)} ",
                      style: TextAppStyle.mainTittel.copyWith(
                        color: Colors.white,
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ],
          );
        },
      ),
    );
  }
}
