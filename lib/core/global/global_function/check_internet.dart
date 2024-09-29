import 'dart:developer';
import 'dart:io';

Future<bool> checkInternetConnection() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      log("message");
      return true;
    }
  } on SocketException catch (_) {
    return false;
  }
  return false;
}
