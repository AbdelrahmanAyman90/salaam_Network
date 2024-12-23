import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';

class PermissionHandelar {
  static Future<bool> checkPermission(Permission permission) async {
    PermissionStatus status = await permission.status;
    log(status.name);
    if (status.isDenied) {
      status = await permission.request();
      if (status.isGranted) {
        return true;
      } else {
        return false;
      }
    } else if (status.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkLocationPermission() async =>
      await checkPermission(Permission.location);

  static Future<bool> checkNotificationPermission() async =>
      await checkPermission(Permission.notification);
}
