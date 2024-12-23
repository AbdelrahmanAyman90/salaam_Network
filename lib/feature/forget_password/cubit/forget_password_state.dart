part of 'forget_password_cubit.dart';

@immutable
sealed class ForgetPasswordState {}

class PasswordResetInitial extends ForgetPasswordState {}

class PasswordResetLoading extends ForgetPasswordState {}

class PasswordResetCodeSent extends ForgetPasswordState {}

class PasswordResetVerified extends ForgetPasswordState {}

class PasswordResetError extends ForgetPasswordState {
  final String error;
  PasswordResetError(this.error);
}

class PasswordUpdated extends ForgetPasswordState {}
