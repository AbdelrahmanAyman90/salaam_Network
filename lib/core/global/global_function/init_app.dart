import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:halqahquran/core/service/bloc_observ.dart';
import 'package:halqahquran/core/service/get_it_service.dart';
import 'package:halqahquran/core/util/app_pref.dart';
import 'package:halqahquran/firebase_options.dart';

Future<void> initApp() async {
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    name: 'halaqa-quran',
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((e) async {
    await SharedPrefService.init();
    setupServiceLocator();
    Bloc.observer = BlocObserverClass();
  });
}
