import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToats(String massage) {
  Fluttertoast.showToast(
    msg: massage,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    fontSize: 18,
  );
}
