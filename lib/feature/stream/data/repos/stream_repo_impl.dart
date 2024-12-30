import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:halqahquran/core/error/network_error.dart';
import 'package:halqahquran/core/global/global_function/get_user_data.dart';
import 'package:halqahquran/core/global/global_function/upload_image.dart';
import 'package:halqahquran/core/service/firebase_sevice.dart';
import 'package:halqahquran/feature/stream/data/model/stream_model.dart';
import 'package:halqahquran/feature/stream/domain/repos/stream_repo.dart';
import 'package:uuid/uuid.dart';

class StreamRepoImpl implements StreamRepo {
  FirebaseService firebaseService;

  StreamRepoImpl({required this.firebaseService});
  @override
  Future<Either<Failure, StreamModel>> endStream() {
    // TODO: implement endStream
    throw UnimplementedError();
  }

  @override
  Future<List<StreamModel>> getStreams() {
    // TODO: implement getStreams
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, StreamModel>> createStream({
    required String streamName,
    required String streamImage,
  }) async {
    try {
      await ImageServiceFirebase.uploadImage(
        fileImagePath: streamImage,
        fileStoreName: 'stream_image',
      );
      String imageUplodedStream = await ImageServiceFirebase.getImageFirebase(
        fileStoreName: 'stream_image',
        imageName: streamImage,
      );
      StreamModel streamModel = StreamModel(
        streamId: const Uuid().v1(),
        streamName: streamName,
        streamImage: imageUplodedStream,
        hostUserName: getUserData().name,
        hostUserImage: getUserData().image,
        userId: firebaseService.getFirebaseUserId(),
      );
      await firebaseService.setData(
        collection: 'streams',
        data: streamModel.toMap(),
      );
      return right(streamModel);
    } on Exception catch (e) {
      if (e is FirebaseException) {
        return left(ServerFailuar.fromFirebaseError(e)); //! return
      } else {
        return left(ServerFailuar(e.toString())); //! return
      }
    }
  }
}
