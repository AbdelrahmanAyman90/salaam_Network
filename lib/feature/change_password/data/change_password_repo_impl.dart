import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:halqahquran/core/error/network_error.dart';
import 'package:halqahquran/feature/change_password/domain/change_password_repo.dart';

class ChangePasswordRepoImpl implements ChangePasswordRepo {
  @override
  Future<Either<Failure, bool>> changePassword(
      {required String oldPassword, required String newPassword}) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final credential = EmailAuthProvider.credential(
        email: user!.email!,
        password: oldPassword,
      );
      await user.reauthenticateWithCredential(credential);
      await user.updatePassword(newPassword);
      return right(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        return left(ServerFailuar("كلمة المرور غير صحيحة"));
      } else {
        return left(ServerFailuar.fromFirebaseAuthError(e)); //! return
      }
    } on Exception catch (e) {
      if (e is FirebaseException) {
        return left(ServerFailuar.fromFirebaseError(e)); //! return
      }
      return left(ServerFailuar("حاول مره اخرى")); //! return
    }
  }
}
