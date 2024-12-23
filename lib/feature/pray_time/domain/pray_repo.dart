import 'package:dartz/dartz.dart';
import 'package:halqahquran/core/error/network_error.dart';
import 'package:halqahquran/feature/pray_time/data/model/pray_time_model.dart';

abstract class PrayTimeRepo {
  Future<Either<Failure, PrayModel>> fetchPrayTime(
      {required String date, required String country});
}
