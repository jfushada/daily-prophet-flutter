import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';

class CommonStore {
  showErrorSnackbar({
    @required BuildContext context,
    String errorMessage,
    String title,
  }) {
    FlushbarHelper.createError(
      message: errorMessage,
      title: title,
      duration: Duration(seconds: 3),
    ).show(context);
  }
}
