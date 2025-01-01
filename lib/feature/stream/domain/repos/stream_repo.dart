import 'package:dartz/dartz.dart';
import 'package:halqahquran/core/error/network_error.dart';
import 'package:halqahquran/feature/stream/data/model/stream_model.dart';

abstract class StreamRepo {
  Future<Either<Failure, StreamModel>> createStream({
    required String streamName,
    required String streamImage,
  });

//!stream
  Stream<List<StreamModel>> getStreams();

  Future<Either<Failure, bool>> endStream(
      {required String streamId, required String imageBeforUpload});
}
