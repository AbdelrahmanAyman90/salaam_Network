part of 'stream_cubit_cubit.dart';

@immutable
sealed class StreamCubitState {}

final class StreamCubitInitial extends StreamCubitState {}

final class CreateStreamLoading extends StreamCubitState {}

final class CreateStreamSuccess extends StreamCubitState {
  final StreamModel streamModel;

  CreateStreamSuccess({required this.streamModel});
}

final class CreateStreamError extends StreamCubitState {
  final String errorMessage;

  CreateStreamError({required this.errorMessage});
}

final class EndStreamError extends StreamCubitState {
  final String errorMessage;

  EndStreamError({required this.errorMessage});
}

final class EndStreamSuccess extends StreamCubitState {}
