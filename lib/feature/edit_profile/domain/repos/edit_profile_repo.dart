import 'package:dartz/dartz.dart';
import 'package:halqahquran/core/error/network_error.dart';

abstract class EditProfileRepo {
  Future<Either<Failure, bool>> updateUserData({
    String? newName,
    String? newEmail,
    String? imageUrl,
  });
  Future<Either<Failure, bool>> verifyEmail(
      {required String newEmail,
      String? newName,
      String? imageUrl,
      required String password});
}
