part of 'quran_cubit.dart';

@immutable
sealed class QuranState {}

final class QuranInitial extends QuranState {}

final class QuranSucsses extends QuranState {}

final class QuranFail extends QuranState {
  String errorMassage;
  QuranFail(this.errorMassage);
}

final class RederDataSuccsess extends QuranState {}

final class RederDataFail extends QuranState {
  String errorMassage;
  RederDataFail(this.errorMassage);
}
