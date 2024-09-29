import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:halqahquran/core/global/global_widget/safescreen.dart';
import 'package:halqahquran/core/theme/size.dart';
import 'package:halqahquran/feature/home/ui/widget/next_pray_card.dart';
import 'package:halqahquran/feature/home/ui/widget/online_widget.dart';
import 'package:halqahquran/feature/home/ui/widget/service_continer.dart';
import 'package:halqahquran/feature/home/ui/widget/top_page_home.dart';
import 'package:halqahquran/feature/muslem_service/cubit/cubit/sevice_muslm_cubit.dart';
import 'package:halqahquran/util/screen_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      child: Padding(
        padding: EdgeInsets.symmetric(
            vertical: AppScreenUtil.getResponsiveHeight(context, .02),
            horizontal: AppScreenUtil.getResponsiveWidth(context, .02)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //!top page
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: TopPageHome()),
            AppSize.hight(5),
            //! next pray
            const NextPrayCard(),
            AppSize.hight(20),
            //! online now
            const OnlineNow(),
            Container(
              height: 1,
              color: Colors.grey,
            ),
            AppSize.hight(15),
            //! service
            BlocProvider(
              create: (context) => MuslumServiceCubit(),
              child: ServiceContainer(),
            ),
          ],
        ),
      ),
    );
  }
}
