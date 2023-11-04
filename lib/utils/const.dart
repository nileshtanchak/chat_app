import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class Const {
  /// Sized Box Const
  static SizedBox customSizedBox({double? height, double? width}) {
    return SizedBox(
      height: height ?? 0,
      width: width ?? 0,
    );
  }

  /// Color Const
  static const Color primaryColor = Colors.blue;
  static const Color greenColor = Colors.green;
}

kPrint(String value) {
  if (kDebugMode) {
    print(value);
  }
}

final box = GetStorage();
