import 'package:bloc/bloc.dart';
import 'package:halqahquran/feature/stream/data/model/stream_model.dart';
import 'package:halqahquran/feature/stream/domain/repos/stream_repo.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'stream_cubit_state.dart';

class StreamCubit extends Cubit<StreamCubitState> {
  StreamCubit({required this.streamRepo}) : super(StreamCubitInitial());
  StreamRepo streamRepo;
  Future<void> createStream({
    required String streamName,
    required String streamImage,
  }) async {
    emit(CreateStreamLoading());

    final result = await streamRepo.createStream(
        streamName: streamName, streamImage: streamImage);
    result.fold(
        (l) => emit(CreateStreamError(errorMessage: l.errorMassage)),
        (r) => emit(CreateStreamSuccess(
              streamModel: r,
            )));
  }
}
