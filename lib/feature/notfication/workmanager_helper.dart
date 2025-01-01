import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:halqahquran/core/global/global_function/fun_to_convert_string_to_timeofday.dart';
import 'package:halqahquran/core/global/global_function/fun_to_get_date.dart';
import 'package:halqahquran/core/service/api_service.dart';
import 'package:halqahquran/core/util/app_pref.dart';
import 'package:halqahquran/core/util/const_varible.dart';
import 'package:halqahquran/feature/notfication/local_notfication_helper.dart';
import 'package:halqahquran/feature/pray_time/data/repo/pray_time_repo.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:workmanager/workmanager.dart';

class WorkManagerService {
  void registerMyTask() async {
    //register my task
    await Workmanager().registerPeriodicTask(
      'id1',
      'show simple notification',
      //change duration for evry day
      frequency: const Duration(days: 1),
    );
  }

  //init work manager service
  Future<void> init() async {
    //! check here the shared pref

    if (LocalNotificationService.isNotificationEnabled() == false) return;

    await Workmanager().initialize(actionTask, isInDebugMode: true);
    registerMyTask();
  }

  Future<void> cancelTask() async {
    await Workmanager().cancelAll();
  }
}

@pragma('vm-entry-point')
void actionTask() {
  Workmanager().executeTask((taskName, inputData) async {
    log("noooooot");
    WidgetsFlutterBinding.ensureInitialized();
    await SharedPrefService.init();
    await initializeDateFormatting('en', null);

    final String currentDate = getDate(0);
    log("currentDate:$currentDate");
    final prayTimeRepo =
        PrayTimeRepoImpl(apiServes: ApiServes(dio: creatdio()));
    final result =
        await prayTimeRepo.fetchPrayTime(date: currentDate, country: 'egypt');

    result.fold(
      (failure) {
        return Future.value(false);
      },
      (prayModel) {
        for (int i = 0; i < praysName.length; i++) {
          final prayerName = praysName[i];
          final prayerTime =
              stringToTimeOfDay(prayModel.timings!.prayerTimes![i]!);

          final isScheduled = SharedPrefService.getBool(prayerName.english);

          if (isScheduled) {
            LocalNotificationService.showDailySchduledNotification(
              prayerName: prayerName.arabic,
              prayerTime: prayerTime,
            );
          }
        }
      },
    );

    return Future.value(true);
  });
}
