import 'package:flutter/material.dart';

class KColors {
  static KColors? singleInstance;

  static KColors getSingleton() {
    singleInstance ??= KColors();
    return singleInstance ?? KColors();
  }

  Color appColor = const Color(0xFFFFEAD1);
  Color dark2 = const Color(0xFF5E5E5F);
  Color dark1 = const Color(0xFF2F3541);
  Color green = const Color(0xFF256203);
  Color red = const Color(0xFFF12424);
  Color blueDark = const Color(0xFF222B45);
  Color lite1 = const Color(0xffF0F0F0);
  Color lite2 = const Color(0xffC7CDE0);
}
