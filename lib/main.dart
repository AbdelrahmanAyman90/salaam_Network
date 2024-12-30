import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_function/fun_to_get_date.dart';
import 'package:halqahquran/core/service/api_service.dart';
import 'package:halqahquran/core/service/bloc_observ.dart';
import 'package:halqahquran/core/service/get_it_service.dart';
import 'package:halqahquran/core/service/shard_pref_service.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/theam.dart';
import 'package:halqahquran/feature/forget_password/cubit/forget_password_cubit.dart';
import 'package:halqahquran/feature/home/ui/screen/bootom_bar.dart';
import 'package:halqahquran/feature/notfication/local_notfication_helper.dart';
import 'package:halqahquran/feature/notfication/workmanager_helper.dart';
import 'package:halqahquran/feature/pray_time/data/repo/pray_time_repo.dart';
import 'package:halqahquran/feature/pray_time/ui/cubit/pray_cubit.dart';
import 'package:halqahquran/feature/theam/cubit/theam_cubit.dart';
import 'package:halqahquran/firebase_options.dart';
import 'package:halqahquran/generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'halaqa-quran',
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((e) async {
    await SharedPrefService.init();

    await Future.wait([
      LocalNotificationService.init(),
      WorkManagerService().init(),
    ]);
  });

  setupServiceLocator();
  Bloc.observer = BlocObserverClass();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              prayTimeRepo: PrayTimeRepoImpl(
                apiServes: ApiServes(dio: creatdio()),
              ),
            )..getPrayTime(getDate(0), 'egypt'),
          ),
          BlocProvider(
            create: (context) => ForgetPasswordCubit(),
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
              home: const BottomNavBar(),
              //LoginView(),
            );
          },
        ),
      ),
    );
  }
}
/**
 * undrstand timer in pray 
 * understand audio player
 * understand view page in quran
 * understand qupla
 * understand sliverlistin reder name list how build this list
 * understand getUserChats
 * undesrstand the bottom life cycle widget in nav
 */
/**

 */
/**
 *! nav user info
 * !send txt
 * !send image
 * !last seen 
 * !if seen 
 * !activ user 
 * call
 */

/**
 * build home stram 
 * only stream in page 
 * creat top page
 * creat continer stream vedio
 * do creat stream
 * 
 */
/**
 * todo edit profile
 * todo change password
 * todo forget password page update password(fake)
 * todo logout
 * 
 */

/**
 * !dialog logout 
 * !not chat yet
 * !add localization arabic
 * !theam scaffold only 
 */