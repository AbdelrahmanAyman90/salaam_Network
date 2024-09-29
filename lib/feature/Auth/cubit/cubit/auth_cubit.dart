import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:halqahquran/core/global/global_function/fun_to_convert_hour.dart';
import 'package:halqahquran/core/network/firebase_sevice.dart';
import 'package:halqahquran/feature/Auth/data/auth_operation.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  AuthOperation auth = AuthOperation();
  FirebaseService firebaseService = FirebaseService();

  Future<void> register(String emial, String password, String name) async {
    emit(AuthLoading());
    try {
      var result = await auth.register(emial, password);
      if (result == "succses") {
        String idUser = await firebaseService.getFirebaseUserId();
        await storeAuthUserData(email: emial, name: name, id: idUser);

        emit(AuthRegisterSucsses());
      } else {
        emit(AuthFaileRegister(errorMassage: result));
      }
    } on Exception catch (e) {
      emit(AuthFaileRegister(errorMassage: e.toString()));
    }
  }

  Future<void> logIN(String emial, String password) async {
    emit(AuthLoading());
    try {
      var result = await auth.signIn(emial, password);
      if (result == "succses") {
        // Store user data in Firestore after successful registration

        emit(AuthLogInSucsses());
      } else {
        emit(AuthFaileLogin(errorMassage: result));
      }
    } on Exception catch (e) {
      emit(AuthFaileLogin(errorMassage: e.toString()));
    }
  }

  Future<void> storeAuthUserData(
      {required String email, required String name, required String id}) async {
    try {
      var userData = {
        'email': email,
        'name': name,
        "id": id,
        'lastSean': convertToArabicAmPm(DateFormat.Hm().format(DateTime.now()))
      };
      await firebaseService.setData(
          collection: 'user_info', data: userData, documentId: id);
    } catch (e) {
      log('Error storing user data: $e');
    }
  }

  @override
  void onChange(Change<AuthState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
