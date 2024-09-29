import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';

abstract class Failure {
  final String errorMassage;
  Failure(this.errorMassage);
}

class ServerFailuar extends Failure {
  ServerFailuar(super.errorMassage);
  factory ServerFailuar.fromDioError(DioException dioError) {
    switch (dioError.type) {
      //all this is dio error type
      case DioExceptionType.connectionTimeout:
        return ServerFailuar(
            "Connection timeout occurred"); //!الرساله دي هتروح للاب والي بدوره هتروح الريبو والي هتبعتها لل  كيبت  الي هيبعتها لل الشاشه
      case DioExceptionType.sendTimeout:
        return ServerFailuar(
            "Send timeout occurred"); //!كاني هنا استدعيت الكون الفاضي الي هو في الاول
      case DioExceptionType.receiveTimeout:
        return ServerFailuar("Receive timeout occurred");
      case DioExceptionType.badCertificate:
        return ServerFailuar("take a more time in server");
      case DioExceptionType.badResponse:
        return ServerFailuar.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailuar("Request was cancelled");

      default:
        if (dioError.error is SocketException) {
          log(dioError.error.toString());
          return ServerFailuar('No Internet Connection');
        } else if (dioError.error.toString().contains("is not a subtype of")) {
          return ServerFailuar('Unable to process the data');
        }
        return ServerFailuar('Unknown error occurred');
    }
  }
  factory ServerFailuar.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      var message = response["data"];
      if (message is int) {
        return ServerFailuar("Error 404!!");
      } else {
        return ServerFailuar(response["status"].toString());
      }
//!change
    } else if (statusCode == 404) {
      return ServerFailuar("Your requst not found");
    } else if (statusCode == 500) {
      return ServerFailuar('tray later');
    } else if (statusCode == 409) {
      return ServerFailuar("Error due to a conflict");
    } else if (statusCode == 408) {
      return ServerFailuar("Connection request timeout");
    } else if (statusCode == 503) {
      return ServerFailuar("Service unavailable");
    } else {
      return ServerFailuar('Oops! An unexpected error occurred');
    }
  }
}
