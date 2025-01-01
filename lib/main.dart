import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halqahquran/core/global/global_function/fun_to_get_date.dart';
import 'package:halqahquran/core/global/global_function/init_app.dart';
import 'package:halqahquran/core/routes/routes_manager.dart';
import 'package:halqahquran/core/service/api_service.dart';
import 'package:halqahquran/core/service/bloc_observ.dart';
import 'package:halqahquran/core/service/get_it_service.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/core/theme/theam.dart';
import 'package:halqahquran/core/util/app_pref.dart';
import 'package:halqahquran/feature/Auth/ui/views/login/login_screen.dart';
import 'package:halqahquran/feature/forget_password/cubit/forget_password_cubit.dart';
import 'package:halqahquran/feature/home/ui/screen/bootom_bar.dart';
import 'package:halqahquran/feature/notfication/local_notfication_helper.dart';
import 'package:halqahquran/feature/notfication/workmanager_helper.dart';
import 'package:halqahquran/feature/pray_time/data/repo/pray_time_repo.dart';
import 'package:halqahquran/feature/pray_time/domain/pray_repo.dart';
import 'package:halqahquran/feature/pray_time/ui/cubit/pray_cubit.dart';
import 'package:halqahquran/feature/stream/domain/repos/stream_repo.dart';
import 'package:halqahquran/feature/stream/ui/cubit/stream_cubit_cubit.dart';
import 'package:halqahquran/feature/theam/cubit/theam_cubit.dart';
import 'package:halqahquran/firebase_options.dart';
import 'package:halqahquran/generated/l10n.dart';
import 'package:halqahquran/start_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initApp();
  runApp(const StartApp());
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