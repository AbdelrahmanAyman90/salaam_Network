import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:halqahquran/core/error/network_error.dart';
import 'package:halqahquran/core/global/global_function/fun_to_get_date.dart';
import 'package:halqahquran/core/global/global_function/get_user_data.dart';
import 'package:halqahquran/core/service/firebase_sevice.dart';
import 'package:halqahquran/feature/edit_profile/domain/repos/edit_profile_repo.dart';

class EditProfileRepoImpl implements EditProfileRepo {
  FirebaseService firebaseService;
  EditProfileRepoImpl({required this.firebaseService});
  @override
  @override
  Future<Either<Failure, bool>> updateUserData({
    String? newName,
    String? newEmail,
    String? imageUrl,
  }) async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.reload();

    // Update other fields in Firestore
    try {
      Map<String, dynamic> updates = {};
      if (newName != null) updates['name'] = newName;
      if (imageUrl != null) updates['image'] = imageUrl;
      if (newEmail != null) updates['email'] = newEmail;

      if (updates.isNotEmpty) {
        await firebaseService.updateData(
            collection: 'user_info',
            documentId: getUserData().id,
            data: updates);

        return right(true);
      } else {
        return left(ServerFailuar("حاول مره اخرى"));
      }
    } on Exception catch (e) {
      log(e.toString());
      if (e is FirebaseAuthException) {
        return left(ServerFailuar.fromFirebaseAuthError(e)); //! return
      } else if (e is FirebaseException) {
        return left(ServerFailuar.fromFirebaseError(e)); //! return
      }
      return left(ServerFailuar("حاول مره اخرى"));
    }
  }

  @override
  Future<Either<Failure, bool>> verifyEmail(
      {required String newEmail,
      String? newName,
      String? imageUrl,
      required String password}) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      await user?.reload();

      log("enter to 1");
      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: password,
      );
      await user.reauthenticateWithCredential(credential);
      await user.verifyBeforeUpdateEmail(newEmail);
      return right(false);
    } on FirebaseAuthException catch (e) {
      log("enter to 3");

      log(e.toString());

      if (e.code == 'invalid-credential') {
        return left(ServerFailuar("كلمة المرور غير صحيحة"));
      }
      if (e.code == 'user-token-expired') {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: newEmail, password: password);
        await updateUserData(
            newEmail: newEmail, imageUrl: imageUrl, newName: newName);
        return right(true);
      } else {
        return left(ServerFailuar("حاول مره اخرى"));
      }
    } on Exception catch (e) {
      log(e.toString());

      if (e is FirebaseException) {
        return left(ServerFailuar.fromFirebaseError(e)); //! return
      }
      return left(ServerFailuar("حاول مره اخرى"));
    }
  }
}
