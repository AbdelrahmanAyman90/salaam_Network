part of 'social_auth_cubit.dart';

@immutable
sealed class SocialAuthState {}

final class SocialAuthInitial extends SocialAuthState {}

final class SocialAuthLoading extends SocialAuthState {}

final class SocialAuthSucsses extends SocialAuthState {}

final class SocialAuthError extends SocialAuthState {
  String errorMassage;
  SocialAuthError({required this.errorMassage});
}
