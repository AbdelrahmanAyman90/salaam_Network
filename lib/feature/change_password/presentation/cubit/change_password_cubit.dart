import 'package:bloc/bloc.dart';
import 'package:halqahquran/feature/change_password/domain/change_password_repo.dart';
import 'package:meta/meta.dart';

part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({required this.changePasswordRepo})
      : super(ChangePasswordInitial());
  ChangePasswordRepo changePasswordRepo;

  changePassword(
      {required String oldPassword, required String newPassword}) async {
    emit(ChangePasswordLoading());
    final result = await changePasswordRepo.changePassword(
        oldPassword: oldPassword, newPassword: newPassword);
    result.fold((l) => emit(ChangePasswordError(errorMassage: l.errorMassage)),
        (r) => emit(ChangePasswordSuccses()));
  }
}
