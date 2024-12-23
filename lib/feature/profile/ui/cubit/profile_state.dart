part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class LogoutLoading extends ProfileState {}

final class LogoutError extends ProfileState {
  String errorMassage;
  LogoutError({required this.errorMassage});
}

final class LogoutSuccess extends ProfileState {}
