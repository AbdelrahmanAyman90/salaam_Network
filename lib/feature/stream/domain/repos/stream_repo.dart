import 'package:dartz/dartz.dart';
import 'package:halqahquran/core/error/network_error.dart';
import 'package:halqahquran/feature/stream/data/model/stream_model.dart';

abstract class StreamRepo {
  Future<Either<Failure, StreamModel>> createStream();
//!stream
  Future<List<StreamModel>> getStreams();
  
  Future<Either<Failure, StreamModel>> endStream();


}
