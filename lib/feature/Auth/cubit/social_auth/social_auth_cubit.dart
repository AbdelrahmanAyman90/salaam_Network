import 'package:bloc/bloc.dart';
import 'package:halqahquran/feature/Auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'social_auth_state.dart';

class SocialAuthCubit extends Cubit<SocialAuthState> {
  SocialAuthCubit({required this.authRepo}) : super(SocialAuthInitial());
  AuthRepo authRepo;
  Future<void> signUseGoogal() async {
    emit(SocialAuthLoading());
    var result = await authRepo.loginWithGoogal();
    result.fold(
      (l) => emit(SocialAuthError(errorMassage: l.errorMassage)),
      (r) async {
        await authRepo.saveUserDataInCache(user: r);
        emit(SocialAuthSucsses());
      },
    );
  }

  Future<void> signUseFacebook() async {
    emit(SocialAuthLoading());
    var result = await authRepo.loginwithFacebook();
    result.fold(
      (l) => emit(SocialAuthError(errorMassage: l.errorMassage)),
      (r) async {
        await authRepo.saveUserDataInCache(user: r);
        emit(SocialAuthSucsses());
      },
    );
  }
}
