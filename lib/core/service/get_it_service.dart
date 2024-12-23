import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:halqahquran/core/service/firebase_auth_service.dart';
import 'package:halqahquran/core/service/firebase_sevice.dart';
import 'package:halqahquran/feature/Auth/data/repo/auth_repo_impl.dart';
import 'package:halqahquran/feature/Auth/domain/repos/auth_repo.dart';
import 'package:halqahquran/feature/change_password/data/change_password_repo_impl.dart';
import 'package:halqahquran/feature/change_password/domain/change_password_repo.dart';
import 'package:halqahquran/feature/edit_profile/data/repo/edit_profile_repo_impl.dart';
import 'package:halqahquran/feature/edit_profile/domain/repos/edit_profile_repo.dart';

final getIt = GetIt.instance;
void setupServiceLocator() {
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
      firebaseAuth: FirebaseAuthService(),
      firebaseService: FirebaseService(),
    ),
  );
  getIt.registerSingleton<EditProfileRepo>(
    EditProfileRepoImpl(
      firebaseService: FirebaseService(),
    ),
  );
  getIt.registerSingleton<ChangePasswordRepo>(ChangePasswordRepoImpl());
}
