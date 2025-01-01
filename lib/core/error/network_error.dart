import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
        return ServerFailuar("حدثت مهلة الاتصال");
      case DioExceptionType.sendTimeout:
        return ServerFailuar("حدثت مهلة أثناء الإرسال");
      case DioExceptionType.receiveTimeout:
        return ServerFailuar("حدثت مهلة أثناء الاستلام");
      case DioExceptionType.badCertificate:
        return ServerFailuar("خطأ في الشهادة");
      case DioExceptionType.badResponse:
        return ServerFailuar.fromResponse(
            dioError.response!.statusCode!, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailuar("تم إلغاء الطلب");
      default:
        if (dioError.error is SocketException) {
          log(dioError.error.toString());
          return ServerFailuar('لا يوجد اتصال بالإنترنت');
        } else if (dioError.error.toString().contains("is not a subtype of")) {
          return ServerFailuar('تعذر معالجة البيانات');
        }
        return ServerFailuar('حدث خطأ غير معروف');
    }
  }

  /// Factory constructor for handling HTTP response errors
  factory ServerFailuar.fromResponse(int statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      var message = response["data"];
      if (message is int) {
        return ServerFailuar("خطأ 404!!");
      } else {
        return ServerFailuar(response["status"].toString());
      }
    } else if (statusCode == 404) {
      return ServerFailuar("طلبك غير موجود");
    } else if (statusCode == 500) {
      return ServerFailuar('حاول مرة أخرى لاحقًا');
    } else if (statusCode == 409) {
      return ServerFailuar("خطأ بسبب تعارض");
    } else if (statusCode == 408) {
      return ServerFailuar("انتهت مهلة طلب الاتصال");
    } else if (statusCode == 503) {
      return ServerFailuar("الخدمة غير متوفرة");
    } else {
      return ServerFailuar('عذرًا! حدث خطأ غير متوقع');
    }
  }

  /// Factory constructor for handling Firebase exceptions
  factory ServerFailuar.fromFirebaseError(FirebaseException firebaseError) {
    switch (firebaseError.code) {
      case 'network-request-failed':
        return ServerFailuar('خطأ في الشبكة: يرجى التحقق من الاتصال');
      case 'invalid-verification-code':
        return ServerFailuar('كود التحقق غير صالح');
      case 'permission-denied':
        return ServerFailuar('تم رفض الإذن: الوصول غير مسموح');
      case 'unauthenticated':
        return ServerFailuar('المستخدم غير مسجل الدخول');
      case 'unavailable':
        return ServerFailuar('الخدمة غير متوفرة: حاول مرة أخرى لاحقًا');
      case 'internal':
        return ServerFailuar('خطأ داخلي في الخادم');
      case 'invalid-argument':
        return ServerFailuar('تم تقديم إدخال غير صالح');
      case 'not-found':
        return ServerFailuar('المورد المطلوب غير موجود');
      default:
        log(firebaseError.message ?? 'خطأ غير معروف في Firebase');
        return ServerFailuar(firebaseError.message ?? 'حدث خطأ غير معروف');
    }
  }

  /// Factory constructor for handling Firebase Authentication exceptions
  factory ServerFailuar.fromFirebaseAuthError(FirebaseAuthException authError) {
    switch (authError.code) {
      case 'invalid-email':
        return ServerFailuar('البريد الإلكتروني غير صالح');
      case 'invalid-credential':
        return ServerFailuar('البريد الإلكتروني أو كلمة المرور غير صحيحة');
      case 'user-disabled':
        return ServerFailuar('تم تعطيل هذا المستخدم');
      case 'user-not-found':
        return ServerFailuar('لم يتم العثور على مستخدم بهذا البريد الإلكتروني');
      case 'wrong-password':
        return ServerFailuar('تم إدخال كلمة مرور غير صحيحة');
      case 'email-already-in-use':
        return ServerFailuar('عنوان البريد الإلكتروني قيد الاستخدام بالفعل');
      case 'weak-password':
        return ServerFailuar('كلمة المرور ضعيفة جدًا');
      case 'network-request-failed':
        return ServerFailuar(
            'فشل طلب الشبكة. يرجى التحقق من اتصالك بالإنترنت.');
      case 'operation-not-allowed':
        return ServerFailuar('هذا الإجراء غير مسموح به');
      case 'too-many-requests':
        return ServerFailuar('طلبات كثيرة جدًا. يرجى المحاولة لاحقًا');
      case 'account-exists-with-different-credential':
        return ServerFailuar(
            'يوجد حساب بنفس البريد الإلكتروني ولكن بيانات اعتماد تسجيل دخول مختلفة');
      default:
        log(authError.message ?? 'خطأ غير معروف في Firebase Auth');
        return ServerFailuar(
            authError.message ?? 'حدث خطأ غير معروف أثناء المصادقة');
    }
  }

  /// Factory constructor to handle Firebase Storage errors
  factory ServerFailuar.fromFirebaseStorageError(
      FirebaseException storageError) {
    switch (storageError.code) {
      case 'object-not-found':
        return ServerFailuar('لا يوجد كائن في المسار المحدد');
      case 'unauthorized':
        return ServerFailuar('الوصول إلى المورد غير مصرح به');
      case 'cancelled':
        return ServerFailuar('تم إلغاء العملية');
      case 'unknown':
        return ServerFailuar('حدث خطأ غير معروف مع Firebase Storage');
      case 'invalid-checksum':
        return ServerFailuar(
            'الملف على العميل لا يتطابق مع التحقق من الصحة على الخادم');
      case 'quota-exceeded':
        return ServerFailuar('تم تجاوز الحصة المخصصة لتخزين Firebase');
      case 'retry-limit-exceeded':
        return ServerFailuar('محاولات إعادة المحاولة كثيرة جدًا');
      case 'download-size-exceeded':
        return ServerFailuar('يتجاوز الملف الذي تم تنزيله الحجم المسموح به');
      default:
        log(storageError.message ?? 'خطأ غير معروف في Firebase Storage');
        return ServerFailuar(
            storageError.message ?? 'حدث خطأ غير معروف أثناء التخزين');
    }
  }
}
