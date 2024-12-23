import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:halqahquran/feature/muslem_service/data/model/quran_model.dart';
import 'package:halqahquran/feature/muslem_service/data/model/reder_model.dart';
import 'package:meta/meta.dart';
part 'quran_state.dart';

class QuranCubit extends Cubit<QuranState> {
  QuranCubit() : super(QuranInitial());
  List<QuranModel> quranDataList = [];
  List<RederModel> rederDataList = [];
  getQuranData() async {
    quranDataList.clear();
    try {
      final String response =
          await rootBundle.loadString('assets/json/quran.json');
      final data = await json.decode(response);
      int index = 0;
      for (var i in data['data']) {
        quranDataList.add(QuranModel.fromJson(i));
      }
      log(quranDataList[0].name.toString());

      emit(QuranSucsses());
    } on Exception catch (e) {
      emit(QuranFail(e.toString()));
    }
  }

  getRederData() async {
    log("enter");
    rederDataList.clear();
    try {
      final String response =
          await rootBundle.loadString('assets/json/audio.json');
      final data = await json.decode(response);
/**
 *         ..sort((firstName, secondNmae) => firstName['name']
 and b['name'] are the names of those reciters, which are being compared using the compareTo() function.
 It returns 0 if the two strings are equal.
It returns a negative number if the first string comes before the second in lexicographical order.
It returns a positive number if the first string comes after the second.
the String.compareTo() method is used to compare two strings lexicographically (i.e., by comparing their Unicode values)
 */
//sort List<Map<String,dynamic>>
      final sortedList = data['reciters'].toList();

      sortedList.sort((firstName, secondNmae) => firstName['name']
          .toString()
          .compareTo(secondNmae['name'].toString()));

      for (var i in sortedList) {
        rederDataList.add(RederModel.fromJson(i));
      }

      log(rederDataList[0].moshaf![0].surahList!.split(',').length.toString());

      emit(RederDataSuccsess());
    } on Exception catch (e) {
      emit(RederDataFail(e.toString()));
    }
  }
}
