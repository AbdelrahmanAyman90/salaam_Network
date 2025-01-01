import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_function/fun_to_get_date.dart';
import 'package:halqahquran/feature/pray_time/ui/cubit/pray_cubit.dart';
import 'package:halqahquran/feature/pray_time/ui/widget/arrow_button.dart';
import 'package:halqahquran/feature/pray_time/ui/widget/display_date_widget.dart';
import 'package:halqahquran/core/util/screen_util.dart';

// ignore: must_be_immutable
class CenterPartOfPrayTime extends StatelessWidget {
  CenterPartOfPrayTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: AppScreenUtil.getResponsiveHeight(context, .25),
      color: const Color(0xFF109A81),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ArrowButton(
            icon: Icons.arrow_back_ios_rounded,
            onPressed: () {
              context.read<PrayCubit>().updatePrayTime(action: "decrese");
            },
          ),
          const DateDisplay(),
          ArrowButton(
            icon: Icons.arrow_forward_ios_rounded,
            onPressed: () {
              context.read<PrayCubit>().updatePrayTime(action: "increase");
            },
          ),
        ],
      ),
    );
  }
}
