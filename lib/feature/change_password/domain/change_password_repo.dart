import 'package:dartz/dartz.dart';
import 'package:halqahquran/core/error/network_error.dart';

abstract class ChangePasswordRepo {
  Future<Either<Failure, bool>> changePassword({
    required String oldPassword,
    required String newPassword,
  });
}
