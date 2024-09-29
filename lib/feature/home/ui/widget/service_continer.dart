import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_function/check_internet.dart';
import 'package:halqahquran/core/global/global_widget/show_toats.dart';
import 'package:halqahquran/util/screen_util.dart';
import 'package:page_transition/page_transition.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/feature/muslem_service/cubit/cubit/sevice_muslm_cubit.dart';

class ServiceContainer extends StatelessWidget {
  ServiceContainer({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<MuslumServiceCubit>(context);

    return BlocConsumer<MuslumServiceCubit, AzkarState>(
      listener: (context, state) {
        if (state is MuslemServiceSuccses) {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              duration: const Duration(milliseconds: 400),
              child: state.pageTrans,
            ),
          );
        }
      },
      builder: (context, state) {
        return Container(
          height: AppScreenUtil.getResponsiveHeight(context, .5),
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10,
              childAspectRatio: 2 / 2.5,
            ),
            itemCount: cubit.serviceMuslimList.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      if (cubit.serviceMuslimList[index].name == "الصلاه" ||
                          cubit.serviceMuslimList[index].name == "القبله") {
                        await checkInternetConnection()
                            ? cubit.serviceMuslimList[index]
                                .onPressed(cubit, index)
                            : showToats("لايوجد اتصال بالانترنت");
                      } else {
                        cubit.serviceMuslimList[index].onPressed(cubit, index);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 65,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColor.primeColor.withOpacity(.5),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      alignment: Alignment.center,
                      child: cubit.serviceMuslimList[index].iconService,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: Text(
                      cubit.serviceMuslimList[index].name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
