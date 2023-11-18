import 'package:flutter/material.dart';

class KColors {
  static KColors? singleInstance;

  static KColors getSingleton() {
    singleInstance ??= KColors();
    return singleInstance ?? KColors();
  }

  Color appColor = Color(0xFFFFEAD1);
  Color dark3 = Color(0xFF324467);
  Color dark2 = Color(0xFF5E5E5F);
  Color dark1 = Color(0xFF2F3541);
  Color green = Color(0xFF256203);
  Color red = Color(0xFFF12424);
  Color red2 = Color(0xFF960707);
  Color blueDark = Color(0xFF222B45);
  Color blueLite = Color(0xFF5E5E5F);
  Color buttonColor1 = Color(0xFFFFF3D7);
  Color gold = Color(0xFFE8A202);
  Color lite1 = Color(0xffF0F0F0);
  Color lite2 = Color(0xffC7CDE0);
  Color border = Color(0xffE7E7E7);
}
