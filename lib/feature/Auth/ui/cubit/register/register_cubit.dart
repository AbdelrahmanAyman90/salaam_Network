import 'package:bloc/bloc.dart';
import 'package:halqahquran/core/global/global_function/upload_image.dart';
import 'package:halqahquran/feature/Auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit({required this.authRepo}) : super(RegisterInitial());
  AuthRepo authRepo;
  Future<void> registerUser(
      {required String name,
      required String email,
      required String password,
      String? image}) async {
    emit(RegisterLoading());

    final result = await authRepo.register(
        name: name, email: email, password: password, image: image);

    result.fold((l) => emit(RegisterError(message: l.errorMassage)), (r) async {
      {
        await authRepo.saveUserDataInCache(user: r);
        emit(RegisterSuccess());
      }
    });
  }
}
