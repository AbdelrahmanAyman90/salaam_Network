import 'package:dartz/dartz.dart';
import 'package:halqahquran/core/error/network_error.dart';
import 'package:halqahquran/feature/Auth/domain/entity/user_entity.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserEntity>> register({
    required String email,
    required String password,
    required String name,
    String? image,
  });

  Future<Either<Failure, UserEntity>> logIN({
    required String email,
    required String password,
  });
  Future<Either<Failure, UserEntity>> loginWithGoogal();
  Future<Either<Failure, UserEntity>> loginwithFacebook();
  Future<void> addUser({required UserEntity userEntity});
  Future<UserEntity> getUserData({required String uId});
  Future<void> saveUserDataInCache({required UserEntity user});
}
