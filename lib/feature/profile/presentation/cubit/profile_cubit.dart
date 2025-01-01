import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:halqahquran/core/util/app_pref.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  logOutUser() async {
    emit(LogoutLoading());
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        await FirebaseAuth.instance.signOut();
        await GoogleSignIn().signOut();
        await FacebookAuth.instance.logOut();
      }
      await SharedPrefService.clearCash();
      emit(LogoutSuccess());
    } on Exception catch (e) {
      emit(LogoutError(errorMassage: "حدث خطأ ما"));
    }
  }

  @override
  void onChange(Change<ProfileState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
