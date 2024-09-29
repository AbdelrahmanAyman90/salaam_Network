import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_function/fun_to_get_date.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/theme/style.dart';
import 'package:halqahquran/feature/home/cubit/cubit/pray_cubit.dart';
import 'package:halqahquran/feature/muslem_service/ui/widget/pray_time_widgets/date_and_arrow_pray_widget.dart';
import 'package:halqahquran/feature/muslem_service/ui/widget/pray_time_widgets/list_of_pray.dart';
import 'package:halqahquran/util/screen_util.dart';

class PrayScreen extends StatelessWidget {
  PrayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Perform your action when the back button is pressed
        context.read<PrayCubit>().updatePrayTime(action: "");

        // Return true to allow the back navigation
        return true;
      },
      child: SafeScaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: AppScreenUtil.getResponsiveHeight(context, .01),
              ),
              Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical:
                          AppScreenUtil.getResponsiveHeight(context, .002)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "اوقات الصلاه",
                        style: TextAppStyle.arabicStyle
                            .copyWith(color: Colors.black, fontSize: 18.sp),
                      ),
                      Directionality(
                        textDirection: TextDirection.ltr,
                        child: IconButton(
                            onPressed: () {
                              // Perform your action when the back button is pressed
                              context
                                  .read<PrayCubit>()
                                  .updatePrayTime(action: "");
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_ios_new)),
                      ),
                    ],
                  ),
                ),
              ),
              BlocBuilder<PrayCubit, PrayState>(
                builder: (context, state) {
                  return state is PrayError
                      ? Text(
                          state.errorMassage,
                          style: const TextStyle(
                              color: Colors.red,
                              fontSize: 32,
                              fontWeight: FontWeight.w400),
                        )
                      : Stack(
                          children: [
                            CenterPartOfPrayTime(),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: AppScreenUtil.getResponsiveHeight(
                                      context, .17),
                                  bottom: AppScreenUtil.getResponsiveHeight(
                                      context, .015)),
                              child: const ListOfPrayTime(),
                            )
                          ],
                        );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
