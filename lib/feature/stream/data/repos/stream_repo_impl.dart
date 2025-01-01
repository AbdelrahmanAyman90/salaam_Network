import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:halqahquran/core/error/network_error.dart';
import 'package:halqahquran/core/global/global_function/get_user_data.dart';
import 'package:halqahquran/core/service/upload_image_service.dart';
import 'package:halqahquran/core/service/firebase_sevice.dart';
import 'package:halqahquran/feature/stream/data/model/stream_model.dart';
import 'package:halqahquran/feature/stream/domain/repos/stream_repo.dart';
import 'package:uuid/uuid.dart';

class StreamRepoImpl implements StreamRepo {
  FirebaseService firebaseService;

  StreamRepoImpl({required this.firebaseService});

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
          userId: getUserData().id,
          imageBeforUpload: streamImage);
      await firebaseService.setData(
        collection: 'streams',
        documentId: streamModel.streamId,
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

  @override
  Stream<List<StreamModel>> getStreams() {
    return FirebaseFirestore.instance
        .collection('streams')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return StreamModel.fromDocument(doc.data());
      }).toList();
    });
  }

  @override
  Future<Either<Failure, bool>> endStream(
      {required String streamId, required String imageBeforUpload}) async {
    try {
      await FirebaseFirestore.instance
          .collection('streams')
          .doc(streamId)
          .delete();

      await ImageServiceFirebase.deleteImageFirebase(
        fileStoreName: 'stream_image',
        imageName: extractFileName(imageBeforUpload),
      );
      return right(true);
    } on Exception catch (e) {
      if (e is FirebaseException) {
        return left(ServerFailuar.fromFirebaseError(e)); //! return
      } else {
        return left(ServerFailuar(e.toString())); //! return
      }
    }
  }
}

String extractFileName(String filePath) {
  return filePath.split('/').last;
}
