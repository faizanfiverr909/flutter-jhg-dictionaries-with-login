import 'package:flutter/material.dart';
import 'package:flutter_guitar/utils/color_constants.dart';

class CustomDialogs {
  static dynamic showTempDialog(BuildContext context, String message) {
    AlertDialog alert = AlertDialog(
      backgroundColor: ColorConstants.midGray,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      content: Container(
          height: 40,
          margin: const EdgeInsets.only(left: 10),
          alignment: Alignment.center,
          child: Text(message)),
    );
    showDialog(
      useRootNavigator: false,
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pop(true);
        });
        return alert;
      },
    );
  }
}
