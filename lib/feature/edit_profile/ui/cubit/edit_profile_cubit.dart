import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:halqahquran/core/global/global_function/fun_to_convert_hour.dart';
import 'package:halqahquran/core/global/global_function/get_user_data.dart';
import 'package:halqahquran/feature/Auth/domain/entity/user_entity.dart';
import 'package:halqahquran/feature/Auth/domain/repos/auth_repo.dart';
import 'package:halqahquran/feature/edit_profile/domain/repos/edit_profile_repo.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit({required this.editProfileRepo, required this.authRepo})
      : super(EditProfileInitial());
  EditProfileRepo editProfileRepo;
  AuthRepo authRepo;

  String currentEmail = getUserData().email;
  bool isEmailSend = false;
  bool isEmailVerified = false;
  void verifyEmail(
      {String? newEmail,
      String? newImage,
      String? newName,
      required String password}) async {
    emit(UserUpdateLaoding());

    final result = await editProfileRepo.verifyEmail(
      newEmail: newEmail ?? currentEmail,
      password: password,
    );
    log(result.toString());
    result.fold(
      (failure) => emit(UserUpdateFaile(errorMassage: failure.errorMassage)),
      (isUpdated) async {
        if (isUpdated) {
          emit(UserUpdateSuccses());
          UserEntity user = UserEntity(
              id: getUserData().id,
              lastSean:
                  convertToArabicAmPm(DateFormat.Hm().format(DateTime.now())),
              name: newName ?? getUserData().name,
              image: newImage ?? getUserData().image,
              email: newEmail ?? currentEmail);
          await authRepo.saveUserDataInCache(user: user);
        } else {
          // emit(UserVerificatiSuccses(isVerifyed: false));
          emit(UserUpdateFaile(errorMassage: "تحقق من البريد الالكتروني"));
        }
      },
    );
  }

  @override
  void onChange(Change<EditProfileState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
