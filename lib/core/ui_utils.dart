import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}

Future<void> showMessageDialog({
  required BuildContext context,
  String? title,
  required String message,
  bool showCancel = false,
  String labelCancel = 'Cancel',
  String labelOk = 'Ok',
  Function()? cancelCallBack,
  required Function() callback,
  bool popOnBackClick = false,
}) {
  if (Platform.isAndroid) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async {
          return popOnBackClick;
        },
        child: AlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions: _getAndroidButtons(
            context,
            showCancel,
            callback,
            labelCancel,
            labelOk,
            cancelCallBack,
          ),
        ),
      ),
    );
  }
  return showCupertinoDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => CupertinoAlertDialog(
      title: title != null ? Text(title) : null,
      content: Text(message),
      actions: _getIOSButtons(
          context, showCancel, callback, labelCancel, labelOk, cancelCallBack),
    ),
  );
}

List<Widget> _getAndroidButtons(
  BuildContext context,
  bool showCancel,
  Function() callback,
  String labelCancel,
  String labelOk,
  Function()? cancelCallBack,
) {
  var widgets = <Widget>[];
  if (showCancel) {
    widgets.add(TextButton(
        onPressed: () => _onTapCancelButton(context, cancelCallBack),
        child: Text(
          labelCancel,
        )));
  }
  widgets.add(TextButton(
    child: Text(labelOk),
    onPressed: () => callback(),
  ));
  return widgets;
}

List<Widget> _getIOSButtons(
  BuildContext context,
  bool showCancel,
  Function() callback,
  String labelCancel,
  String labelOk,
  Function()? cancelCallBack,
) {
  var widgets = <Widget>[];
  if (showCancel) {
    widgets.add(CupertinoDialogAction(
        onPressed: () => _onTapCancelButton(context, cancelCallBack),
        child: Text(labelCancel)));
  }

  widgets.add(CupertinoDialogAction(
    child: Text(
      labelOk,
    ),
    onPressed: () => callback(),
  ));
  return widgets;
}

void _onTapCancelButton(BuildContext context, Function()? cancelCallBack) {
  Navigator.pop(context);
  if (cancelCallBack != null) {
    cancelCallBack();
  }
}
