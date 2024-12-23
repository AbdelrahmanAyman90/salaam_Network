import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:halqahquran/core/service/api_service.dart';
import 'package:halqahquran/core/error/network_error.dart';
import 'package:halqahquran/feature/pray_time/data/model/pray_time_model.dart';
import 'package:halqahquran/feature/pray_time/domain/pray_repo.dart';

class PrayTimeRepoImpl implements PrayTimeRepo {
  final ApiServes apiServes;

  PrayTimeRepoImpl({required this.apiServes});

  @override
  Future<Either<Failure, PrayModel>> fetchPrayTime(
      {required String date, required String country}) async {
    try {
      //do requst
      var response = await apiServes.get(
        link:
            "https://api.aladhan.com/v1/timingsByCity/$date?city=wei&country=$country",
      );
      //do parse
      PrayModel data = PrayModel.fromJson(response['data']);

      return right(data);
    } on Exception catch (e) {
      if (e is DioException) {
        log(e.toString());
        return left(ServerFailuar.fromDioError(e)); //! return
      } else {
        return left(ServerFailuar(e.toString())); //! return
      }
    }
  }
}
//https://api.aladhan.com/v1/timingsByCity/03-08-2024?city=wei&country=egypt
