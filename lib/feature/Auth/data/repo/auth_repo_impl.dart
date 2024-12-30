import 'dart:convert';
import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:halqahquran/core/error/network_error.dart';
import 'package:halqahquran/core/global/global_function/fun_to_convert_hour.dart';
import 'package:halqahquran/core/global/global_function/upload_image.dart';
import 'package:halqahquran/core/service/firebase_auth_service.dart';
import 'package:halqahquran/core/service/firebase_sevice.dart';
import 'package:halqahquran/core/service/shard_pref_service.dart';
import 'package:halqahquran/core/util/const_varible.dart';
import 'package:halqahquran/feature/Auth/data/model/user_model.dart';
import 'package:halqahquran/feature/Auth/domain/entity/user_entity.dart';
import 'package:halqahquran/feature/Auth/domain/repos/auth_repo.dart';
import 'package:intl/intl.dart';

class AuthRepoImpl implements AuthRepo {
  FirebaseAuthService firebaseAuth;
  FirebaseService firebaseService;
  AuthRepoImpl({required this.firebaseAuth, required this.firebaseService});
  @override
  Future<void> addUser({required UserEntity userEntity}) async {
    await firebaseService.setData(
      collection: 'user_info',
      data: UserModel.fromUserEntity(userEntity).toMap(),
      documentId: userEntity.id,
    );
  }

  @override
  Future<UserEntity> getUserData({required String uId}) async {
    var userData =
        await firebaseService.getData(collection: 'user_info', documentId: uId);
    return UserModel.fromDocument(userData.data() as Map<String, dynamic>);
  }

  @override
  Future<Either<Failure, UserEntity>> logIN(
      {required String email, required String password}) async {
    try {
      User user =
          await firebaseAuth.signInWithEmailAndPassword(email, password);
      var userEntity = await getUserData(uId: user.uid);
      return right(userEntity);
    } on Exception catch (e) {
      log(e.toString());
      if (e is FirebaseAuthException) {
        return left(ServerFailuar.fromFirebaseAuthError(e)); //! return
      } else if (e is FirebaseException) {
        return left(ServerFailuar.fromFirebaseError(e)); //! return
      }
      return left(ServerFailuar("حاول مره اخرى")); //! return
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginWithGoogal() async {
    User? user;
    try {
      user = await firebaseAuth.signInWithGoogle();
      UserEntity userEntity = UserModel.fromFirebase(user);
      var isUserExist = await firebaseService.checkIsExist(
        path: 'user_info',
        docId: userEntity.id,
      );
      if (isUserExist) {
        userEntity = await getUserData(uId: userEntity.id);
      } else {
        await addUser(userEntity: userEntity);
      }
      return right(userEntity);
    } on Exception catch (e) {
      log(e.toString());
      if (user != null) {
        await user.delete();
      }
      if (e is FirebaseAuthException) {
        return left(ServerFailuar.fromFirebaseAuthError(e)); //! return
      } else if (e is FirebaseException) {
        return left(ServerFailuar.fromFirebaseError(e)); //! return
      }
      return left(ServerFailuar("حاول مره اخرى")); //! return
    }
  }

  @override
  Future<Either<Failure, UserEntity>> loginwithFacebook() async {
    User? user;
    try {
      user = await firebaseAuth.signInWithFacebook();
      UserEntity userEntity = UserModel.fromFirebase(user);
      var isUserExist = await firebaseService.checkIsExist(
        path: 'user_info',
        docId: userEntity.id,
      );
      if (isUserExist) {
        userEntity = await getUserData(uId: userEntity.id);
      } else {
        await addUser(userEntity: userEntity);
      }
      return right(userEntity);
    } on Exception catch (e) {
      log(e.toString());
      if (user != null) {
        await user.delete();
      }
      if (e is FirebaseAuthException) {
        return left(ServerFailuar.fromFirebaseAuthError(e)); //! return
      } else if (e is FirebaseException) {
        return left(ServerFailuar.fromFirebaseError(e)); //! return
      }
      return left(ServerFailuar("حاول مره اخرى")); //! return
    }
  }

  @override
  Future<Either<Failure, UserEntity>> register(
      {required String email,
      required String password,
      required String name,
      String? image}) async {
    User? user;

    try {
      user = await firebaseAuth.createUserWithEmailAndPassword(email, password);
      if (image != null) {
        // Upload image
        await ImageServiceFirebase.uploadImage(
          fileImagePath: image,
          fileStoreName: 'image_profile',
        );
        // Get the image URL
        image = await ImageServiceFirebase.getImageFirebase(
          fileStoreName: 'image_profile',
          imageName: image,
        );
      }
      var userEntity = UserEntity(
        name: name,
        email: email,
        id: user.uid,
        image: image,
        lastSean: convertToArabicAmPm(timeFormat.format(DateTime.now())),
      );
      // Store user data
      await addUser(userEntity: userEntity);

      return right(userEntity);
    } on Exception catch (e) {
      log(e.toString()); // Log the exact type and message of the exception

      // Clean up resources
      if (user != null) {
        await user.delete();

        if (image != null) {
          await ImageServiceFirebase.deleteImageFirebase(
            fileStoreName: 'image_profile',
            imageName: image,
          );
        }
      }
      // Handle FirebaseAuthException
      if (e is FirebaseAuthException) {
        return left(ServerFailuar.fromFirebaseAuthError(e));
      }

      // Handle Firebase Storage or other Firebase-related exceptions
      if (e is FirebaseException) {
        // Handle specific Firebase Storage errors
        if (e.plugin == 'firebase_storage') {
          return left(ServerFailuar.fromFirebaseStorageError(e));
        }
        return left(ServerFailuar.fromFirebaseError(e));
      }

      // Handle any other exceptions
      return left(ServerFailuar("حاول مره اخرى")); //! return
    }
  }

  @override
  Future<void> saveUserDataInCache({required UserEntity user}) async {
    var jsonData = jsonEncode(
      UserModel.fromUserEntity(user).toMap(),
    ); // convert to json(string)
    await SharedPrefService.setString(kUser, jsonData);
  }
}
