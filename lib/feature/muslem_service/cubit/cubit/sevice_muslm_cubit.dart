import 'dart:convert';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:halqahquran/core/theme/color.dart';
import 'package:halqahquran/feature/Auth/ui/views/login/login_screen.dart';
import 'package:halqahquran/feature/home/data/model/servise_model.dart';
import 'package:halqahquran/feature/muslem_service/data/model/azkar_model.dart';
import 'package:halqahquran/feature/muslem_service/data/model/dua_model.dart';
import 'package:halqahquran/feature/muslem_service/data/model/hadeth_model.dart';
import 'package:halqahquran/feature/pray_time/ui/views/pray_screen.dart';
import 'package:halqahquran/feature/muslem_service/ui/screen/qubla_screen.dart';
import 'package:halqahquran/feature/quran/ui/screen/quran_screen.dart';
import 'package:halqahquran/feature/muslem_service/ui/screen/read_zekr_and_hadeth_screen.dart';
import 'package:halqahquran/feature/muslem_service/ui/screen/tasabih_screen.dart';
import 'package:halqahquran/feature/muslem_service/ui/screen/zekr_screen.dart';
import 'package:meta/meta.dart';
import 'package:page_transition/page_transition.dart';

part 'sevice_muslm_state.dart';

class MuslumServiceCubit extends Cubit<AzkarState> {
  MuslumServiceCubit() : super(MuslemServiceInitial());

  List<AzkarModel> azkarList = [];
  List<DuaModel> duaQuranList = [];
  List<DuaModel> duaNapiList = [];
  List<DuaModel> duaMohamedList = [];
  List<HadethModel> hadehtList = [];

  final List<ServiceModel> serviceMuslimList = [
    ServiceModel(
      iconService: const Icon(
        FlutterIslamicIcons.prayingPerson,
        size: 50,
        color: AppColor.primeColor,
      ),
      onPressed: (cubit, index) {
        cubit.getPray(index);
      },
      name: "الصلاه",
    ),
    ServiceModel(
      iconService: const Icon(
        FlutterIslamicIcons.quran,
        size: 50,
        color: AppColor.primeColor,
      ),
      onPressed: (cubit, index) {
        cubit.getQuran(index);
      },
      name: "القران",
    ),
    ServiceModel(
      iconService: const Icon(
        FlutterIslamicIcons.allah,
        size: 50,
        color: AppColor.primeColor,
      ),
      onPressed: (cubit, index) {
        cubit.getAzkar(index);
      },
      name: "أذكار المسلم",
    ),
    ServiceModel(
      iconService: const Icon(
        FlutterIslamicIcons.qibla,
        size: 50,
        color: AppColor.primeColor,
      ),
      onPressed: (cubit, index) {
        cubit.getQubla(index);
      },
      name: "القبله",
    ),
    ServiceModel(
      iconService: const Icon(
        Icons.menu_book_sharp,
        size: 50,
        color: AppColor.primeColor,
      ),
      onPressed: (cubit, index) {
        cubit.getHadeht(index);
      },
      name: "اﻷربعون النوويه",
    ),
    ServiceModel(
      iconService: const Icon(
        FlutterIslamicIcons.mohammad,
        size: 50,
        color: AppColor.primeColor,
      ),
      onPressed: (cubit, index) {
        cubit.getDuaMohamed(index);
      },
      name: "ادعيه نبويه",
    ),
    ServiceModel(
      iconService: const Icon(
        FlutterIslamicIcons.prayer,
        size: 50,
        color: AppColor.primeColor,
      ),
      onPressed: (cubit, index) {
        cubit.getDuaNapi(index);
      },
      name: "ادعيه الانبياء",
    ),
    ServiceModel(
      iconService: const Icon(
        FlutterIslamicIcons.quran2,
        size: 50,
        color: AppColor.primeColor,
      ),
      onPressed: (cubit, index) {
        cubit.getDuaQurans(index);
      },
      name: "ادعيه قرانيه",
    ),
    ServiceModel(
      iconService: const Icon(
        FlutterIslamicIcons.tasbih2,
        size: 50,
        color: AppColor.primeColor,
      ),
      onPressed: (cubit, index) {
        cubit.getTabeh(index);
      },
      name: "التسبيح",
    ),
  ];

  getAzkar(int index) async {
    azkarList.clear();
    try {
      final String response =
          await rootBundle.loadString('assets/json/azkar.json');
      final data = await json.decode(response);

      for (var i in data) {
        azkarList.add(AzkarModel.fromJson(i));
      }
      log(azkarList.length.toString());

      emit(MuslemServiceSuccses(
          index: index,
          pageTrans: ReadZekrAndHadethScreen(
            serviceListData: azkarList,
            tittel: "اذكار المسلم",
          )));
    } on Exception catch (e) {
      emit(MuslemServiceFail(msg: e.toString()));
    }
  }

  getDuaQurans(int index) async {
    duaQuranList.clear();
    try {
      final String response =
          await rootBundle.loadString('assets/json/dua_quran.json');
      final data = await json.decode(response);

      for (var i in data) {
        duaQuranList.add(DuaModel.fromJson(i));
      }
      log(duaQuranList.length.toString());

      emit(MuslemServiceSuccses(
          index: index,
          pageTrans: ZekrScreen(
            iteamListData: duaQuranList,
            tittel: "ادعيه قرانيه",
          )));
    } on Exception catch (e) {
      emit(MuslemServiceFail(msg: e.toString()));
    }
  }

  getDuaNapi(int index) async {
    duaQuranList.clear();
    try {
      final String response =
          await rootBundle.loadString('assets/json/dua_napi.json');
      final data = await json.decode(response);

      for (var i in data) {
        duaNapiList.add(DuaModel.fromJson(i));
      }
      log(duaNapiList.length.toString());

      emit(MuslemServiceSuccses(
          index: index,
          pageTrans: ZekrScreen(
            iteamListData: duaNapiList,
            tittel: "ادعيه الانبياء",
          )));
    } on Exception catch (e) {
      emit(MuslemServiceFail(msg: e.toString()));
    }
  }

  getDuaMohamed(int index) async {
    duaQuranList.clear();
    try {
      final String response =
          await rootBundle.loadString('assets/json/dua_mohmed.json');
      final data = await json.decode(response);

      for (var i in data) {
        duaMohamedList.add(DuaModel.fromJson(i));
      }
      log(duaMohamedList.length.toString());

      emit(MuslemServiceSuccses(
          index: index,
          pageTrans: ZekrScreen(
            iteamListData: duaMohamedList,
            tittel: "ادعيه نبويه",
          )));
    } on Exception catch (e) {
      emit(MuslemServiceFail(msg: e.toString()));
    }
  }

  getHadeht(int index) async {
    hadehtList.clear();
    try {
      final String response =
          await rootBundle.loadString('assets/json/hadeth40.json');
      final data = await json.decode(response);

      for (var i in data) {
        hadehtList.add(HadethModel.fromJson(i));
      }
      log(hadehtList.length.toString());

      emit(MuslemServiceSuccses(
          index: index,
          pageTrans: ReadZekrAndHadethScreen(
            serviceListData: hadehtList,
            tittel: "الاربعون النوويه",
          )));
    } on Exception catch (e) {
      emit(MuslemServiceFail(msg: e.toString()));
    }
  }

  getTabeh(int index) async {
    emit(MuslemServiceSuccses(index: index, pageTrans: TsbihScreen()));
  }

  getPray(int index) async {
    emit(MuslemServiceSuccses(index: index, pageTrans: PrayScreen()));
  }

  getQubla(int index) {
    emit(MuslemServiceSuccses(index: index, pageTrans: QublaScreen()));
  }

  getQuran(int index) async {
    emit(MuslemServiceSuccses(index: index, pageTrans: QuranScreen()));
  }
}
