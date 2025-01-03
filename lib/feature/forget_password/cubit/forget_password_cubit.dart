import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(PasswordResetInitial());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _verificationId;

  // Send SMS to the user's phone
  Future<void> sendSms({required String phoneNumber}) async {
    emit(PasswordResetLoading());
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        //phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            emit(PasswordResetError("رقم الهاتف غير صحيح"));
          } else if (e.code == 'invalid-verification-code') {
            emit(PasswordResetError("رمز التحقق غير صحيح"));
          } else {
            emit(PasswordResetError("Failed : $e"));
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          emit(PasswordResetCodeSent()); //!
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationId = verificationId;
        },
      );
    } catch (e) {
      emit(PasswordResetError("Failed to send SMS: $e"));
    }
  }

  // Verify the code entered by the user
  Future<void> verifyCode({required String smsCode}) async {
    emit(PasswordResetLoading());
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: _verificationId!,
        smsCode: smsCode,
      );
      await _auth.signInWithCredential(credential);
      emit(PasswordResetVerified()); //!
    } on Exception catch (e) {
      log(e.toString());
      if (e is FirebaseAuthException) {
        if (e.code == 'invalid-phone-number') {
          emit(PasswordResetError("رقم الهاتف غير صحيح"));
        } else if (e.code == 'invalid-verification-code') {
          emit(PasswordResetError("رمز التحقق غير صحيح"));
        } else {
          emit(PasswordResetError("Failed : $e"));
        }
      }
    }
  }

  // Update the user's password
  Future<void> updatePassword({required String newPassword}) async {
    emit(PasswordResetLoading());
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await user.updatePassword(newPassword);
        emit(PasswordUpdated()); //!
      } else {
        emit(PasswordResetError("No user is currently signed in."));
      }
    } catch (e) {
      emit(PasswordResetError("Failed to update password: $e"));
    }
  }

  @override
  void onChange(Change<ForgetPasswordState> change) {
    log(change.toString());
    super.onChange(change);
  }
}
//! phone
//! code 
//! update