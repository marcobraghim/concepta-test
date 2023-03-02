import 'dart:developer' as developer;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// This functions is supposed to be used when you
/// want to print something on the debug console,
/// but on the VS Code it will be shown yellow
void debug(Object? message, {String? label}) {
  if (kDebugMode) {
    developer.log(
      message.toString(),
      name: label ?? 'mylog',
      time: DateTime.now(),
      sequenceNumber: DateTime.now().millisecondsSinceEpoch,
    );
  }
}

void unfocus(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
}
