import 'package:bloc/bloc.dart';
import 'package:halqahquran/feature/Auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.authRepo}) : super(LoginInitial());
  AuthRepo authRepo;
  loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());

    var result = await authRepo.logIN(email: email, password: password);

    result.fold((l) {
      emit(LoginError(message: l.errorMassage));
    }, (r) async {
      await authRepo.saveUserDataInCache(user: r);
      emit(LoginSuccess());
    });
  }
}
