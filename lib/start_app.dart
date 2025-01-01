import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_function/fun_to_get_date.dart';
import 'package:halqahquran/core/routes/routes_manager.dart';
import 'package:halqahquran/core/service/get_it_service.dart';
import 'package:halqahquran/core/theme/theam.dart';
import 'package:halqahquran/core/util/app_pref.dart';
import 'package:halqahquran/feature/Auth/ui/views/login/login_screen.dart';
import 'package:halqahquran/feature/home/ui/screen/bootom_bar.dart';
import 'package:halqahquran/feature/pray_time/domain/pray_repo.dart';
import 'package:halqahquran/feature/pray_time/ui/cubit/pray_cubit.dart';
import 'package:halqahquran/feature/theam/cubit/theam_cubit.dart';
import 'package:halqahquran/generated/l10n.dart';

class StartApp extends StatelessWidget {
  const StartApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => PrayCubit(
              prayTimeRepo: getIt<PrayTimeRepo>(),
            )..getPrayTime(getDate(0), 'egypt'),
          ),
          BlocProvider(
            create: (context) =>
                TheamCubit()..loadTheme(), // Load the theme on app startup
          ),
        ],
        child: BlocBuilder<TheamCubit, TheamState>(
          builder: (context, state) {
            return MaterialApp(
              locale: const Locale('ar'),
              localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              debugShowCheckedModeBanner: false,
              themeMode: state is DarkThemeState
                  ? ThemeMode.dark
                  : ThemeMode.light, // Use the themeMode from the state
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              onGenerateRoute: ongenerateRoute,
              initialRoute: SharedPrefService.getBool(kuserIsLogin)
                  ? HomeScreen.routeName
                  : LoginView.routeName,
            );
          },
        ),
      ),
    );
  }
}
