part of 'sevice_muslm_cubit.dart';

@immutable
sealed class AzkarState {}

final class MuslemServiceInitial extends AzkarState {}

final class MuslemServiceSuccses extends AzkarState {
  int index;
  Widget pageTrans;
  MuslemServiceSuccses({required this.index, required this.pageTrans});
}

final class MuslemServiceFail extends AzkarState {
  final String msg;
  MuslemServiceFail({required this.msg});
}
