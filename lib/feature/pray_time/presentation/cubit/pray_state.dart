part of 'pray_cubit.dart';

@immutable
sealed class PrayState {}

class PrayInitial extends PrayState {}

class PrayLoading extends PrayState {}

class PrayLoaded extends PrayState {
  PrayModel prayData;
  PrayLoaded(this.prayData);
}

class PrayLoadingWithPrevious extends PrayState {
  final PrayModel previousPrayData;
  PrayLoadingWithPrevious(this.previousPrayData);
}

class PrayError extends PrayState {
  final String errorMassage;
  PrayError(this.errorMassage);
}

class NextPrayLoded extends PrayState {}
