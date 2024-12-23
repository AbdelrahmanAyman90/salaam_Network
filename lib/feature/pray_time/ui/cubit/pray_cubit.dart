import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:halqahquran/core/global/global_function/fun_to_get_date.dart';
import 'package:halqahquran/feature/pray_time/data/model/pray_time_model.dart';
import 'package:halqahquran/feature/pray_time/domain/pray_repo.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

part 'pray_state.dart';

class PrayCubit extends Cubit<PrayState> {
  PrayTimeRepo prayTimeRepo; //call api
  PrayModel? previousPrayData; // Store the previous prayer data
  int day = 0; //to init day
  String?
      currentDate; //to can compare between it and another date to change card color
  Map<int, String>? dateOfNextPray; //to show card date
  PrayCubit({required this.prayTimeRepo}) : super(PrayInitial());

  Future<void> getPrayTime(String date, String country) async {
    if (previousPrayData != null) {
      // Emit loading state with previous data to show the current data while fetching
      emit(PrayLoadingWithPrevious(previousPrayData!));
    } else {
      // If no previous data, just show loading
      emit(PrayLoading());
    }

    var result = await prayTimeRepo.fetchPrayTime(date: date, country: country);

    try {
      result.fold(
        (l) {
          emit(PrayError(l.errorMassage));
        },
        (r) async {
          previousPrayData =
              r; // Store the new data as the previous data for future loads
          if (day == 0) {
            calculateNextPray(r); //calculate nextpray for roday only
          }
          currentDate = r.date!.date; //to change color of next pray time
          emit(PrayLoaded(r)); // Emit the newly loaded data
        },
      );
    } on Exception catch (e) {
      emit(PrayError(e.toString()));
    }
  }

  updatePrayTime({required String action}) async {
    String? date;
    if (action == 'increase') {
      day++;
      date = getDate(day);
    } else if (action == 'decrese') {
      day--;
      date = getDate(day);
    } else {
      day = 0;
      date = getDate(day);
    }

    try {
      await getPrayTime(date, "egypt");
    } catch (e) {
      emit(PrayError(e.toString()));
    }
  }

  calculateNextPray(PrayModel r) {
    List<String?> praysTimeng = r.timings!.prayerTimes!;

    DateTime now = DateTime.now();
    DateFormat timeFormat = DateFormat("HH:mm");
    List<DateTime> prayerDateTimes = praysTimeng.map((time) {
      return DateTime(now.year, now.month, now.day,
          timeFormat.parse(time!).hour, timeFormat.parse(time).minute);
    }).toList();

    DateTime? nextPrayer;
    int index = 0;

    // Loop through the prayers and find the next prayer
    for (var i in prayerDateTimes) {
      if (now.isBefore(i)) {
        nextPrayer = i;
        break;
      }
      index++;
    }

    // If no next prayer is found (all prayers have passed for the day)
    if (nextPrayer == null) {
      // Set the next prayer to Fajr of the next day
      nextPrayer = prayerDateTimes.first.add(const Duration(days: 1));
      index = 0; // Index for Fajr
    }

    dateOfNextPray = {index: timeFormat.format(nextPrayer)};
    log(index.toString());
  }
}

//https://api.aladhan.com/v1/timingsByCity/03-08-2024?city=wei&country=egypt