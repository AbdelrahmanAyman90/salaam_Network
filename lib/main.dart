import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_function/fun_to_get_date.dart';
import 'package:halqahquran/core/network/api_service.dart';
import 'package:halqahquran/feature/Auth/cubit/cubit/auth_cubit.dart';
import 'package:halqahquran/feature/Auth/ui/screen/login/login_screen.dart';
import 'package:halqahquran/feature/Auth/ui/screen/register/register_screen.dart';
import 'package:halqahquran/feature/chat/cubit/cubit/chat_cubit.dart';
import 'package:halqahquran/feature/home/cubit/cubit/pray_cubit.dart';
import 'package:halqahquran/feature/home/data/repo/pray_time_repo.dart';
import 'package:halqahquran/feature/home/ui/screen/bootom_bar.dart';
import 'package:halqahquran/feature/home/ui/screen/home_body.dart';
import 'package:halqahquran/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

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
                prayTimeRepo:
                    PrayTimeRepo(apiServes: ApiServes(dio: creatdio())))
              ..getPrayTime(getDate(0), 'egypt'),
          ),
          BlocProvider(
            create: (context) => AuthCubit(),
          ),
          BlocProvider(
            create: (context) => ChatCubit(),
          ),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white.withOpacity(.95),
            ),
            home: BottomNavBar()
            //LoginScreen(),
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
 * 
 */