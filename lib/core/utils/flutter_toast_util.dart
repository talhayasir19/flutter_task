import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

abstract class FlutterToastUtil {
  void showToast({
    required String text,
  });
}

class FlutterToastUtilImpl extends FlutterToastUtil {
  @override
  void showToast({
    required String text,
  }) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        timeInSecForIosWeb: 1,
        backgroundColor: Color.fromRGBO(5, 5, 5, 0.6),
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
