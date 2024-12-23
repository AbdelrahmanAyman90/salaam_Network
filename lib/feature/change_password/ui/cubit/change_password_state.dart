part of 'change_password_cubit.dart';

@immutable
sealed class ChangePasswordState {}

final class ChangePasswordInitial extends ChangePasswordState {}

final class ChangePasswordSuccses extends ChangePasswordState {}

final class ChangePasswordError extends ChangePasswordState {
  String errorMassage;
  ChangePasswordError({required this.errorMassage});
}

final class ChangePasswordLoading extends ChangePasswordState {}
