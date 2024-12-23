import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:halqahquran/core/error/ecxption.dart';

abstract class Failure {
  final String errorMassage;
  Failure(this.errorMassage);
}

class ServerFailuar extends Failure {
  ServerFailuar(super.errorMassage);

  /// Factory constructor for handling Dio exceptions
  factory ServerFailuar.fromDioError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailuar("Connection timeout occurred");
      case DioExceptionType.sendTimeout:
        return ServerFailuar("Send timeout occurred");
      case DioExceptionType.receiveTimeout:
        return ServerFailuar("Receive timeout occurred");
      case DioExceptionType.badCertificate:
        return ServerFailuar("Bad certificate error");
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

  /// Factory constructor for handling HTTP response errors
  factory ServerFailuar.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      var message = response["data"];
      if (message is int) {
        return ServerFailuar("Error 404!!");
      } else {
        return ServerFailuar(response["status"].toString());
      }
    } else if (statusCode == 404) {
      return ServerFailuar("Your request not found");
    } else if (statusCode == 500) {
      return ServerFailuar('Try again later');
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

  /// Factory constructor for handling Firebase exceptions
  factory ServerFailuar.fromFirebaseError(FirebaseException firebaseError) {
    switch (firebaseError.code) {
      case 'network-request-failed':
        return ServerFailuar('Network error: Please check your connection');
      case 'permission-denied':
        return ServerFailuar('Permission denied: Access not allowed');
      case 'unauthenticated':
        return ServerFailuar('User not authenticated');
      case 'unavailable':
        return ServerFailuar('Service unavailable: Try again later');
      case 'internal':
        return ServerFailuar('Internal server error');
      case 'invalid-argument':
        return ServerFailuar('Invalid input provided');
      case 'not-found':
        return ServerFailuar('Requested resource not found');
      default:
        log(firebaseError.message ?? 'Unknown Firebase error');
        return ServerFailuar(
            firebaseError.message ?? 'An unknown error occurred');
    }
  }

  /// Factory constructor for handling Firebase Authentication exceptions
  factory ServerFailuar.fromFirebaseAuthError(FirebaseAuthException authError) {
    //invalid-credential
    switch (authError.code) {
      case 'invalid-email':
        return ServerFailuar('The email address is not valid');
      case 'invalid-credential':
        return ServerFailuar('passord or emial incorrect');
      case 'user-disabled':
        return ServerFailuar('This user has been disabled');
      case 'user-not-found':
        return ServerFailuar('No user found with this email');
      case 'wrong-password':
        return ServerFailuar('Incorrect password entered');
      case 'email-already-in-use':
        return ServerFailuar('The email address is already in use');
      case 'weak-password':
        return ServerFailuar('The password is too weak');
      case 'operation-not-allowed':
        return ServerFailuar('This operation is not allowed');
      case 'too-many-requests':
        return ServerFailuar('Too many requests. Please try again later');
      case 'account-exists-with-different-credential':
        return ServerFailuar(
            'An account already exists with the same email but different sign-in credentials');
      default:
        log(authError.message ?? 'Unknown Firebase Auth error');
        return ServerFailuar(
            authError.message ?? 'An unknown authentication error occurred');
    }
  }
  // Factory constructor to handle Firebase Storage errors
  factory ServerFailuar.fromFirebaseStorageError(
      FirebaseException storageError) {
    switch (storageError.code) {
      case 'object-not-found':
        return ServerFailuar('No object exists at the specified path');
      case 'unauthorized':
        return ServerFailuar('Unauthorized access to the specified resource');
      case 'cancelled':
        return ServerFailuar('The operation was canceled');
      case 'unknown':
        return ServerFailuar('An unknown error occurred with Firebase Storage');
      case 'invalid-checksum':
        return ServerFailuar(
            'File on the client does not match the checksum on the server');
      case 'quota-exceeded':
        return ServerFailuar('Quota for Firebase Storage has been exceeded');
      case 'retry-limit-exceeded':
        return ServerFailuar('Too many retry attempts for the operation');
      case 'download-size-exceeded':
        return ServerFailuar(
            'The downloaded file exceeds the maximum allowed size');
      default:
        log(storageError.message ?? 'Unknown Firebase Storage error');
        return ServerFailuar(
            storageError.message ?? 'An unknown storage error occurred');
    }
  }
}
