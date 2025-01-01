part of 'edit_profile_cubit.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}

final class UserVerificatiSuccses extends EditProfileState {
  bool isVerifyed;
  UserVerificatiSuccses({required this.isVerifyed});
}

final class UserUpdateSuccses extends EditProfileState {}

final class UserUpdateFaile extends EditProfileState {
  String errorMassage;
  UserUpdateFaile({required this.errorMassage});
}

final class UserUpdateLaoding extends EditProfileState {}
