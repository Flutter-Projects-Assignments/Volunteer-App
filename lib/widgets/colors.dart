import 'dart:ui';
import 'package:flutter/material.dart';

Color hexToColor(String hex) {
  assert(RegExp(r'^#([0-9a-fA-F]{6})|([0-9a-fA-F]{8})$').hasMatch(hex),
      'hex color must be #rrggbb or #rrggbbaa');

  return Color(
    int.parse(hex.substring(1), radix: 16) +
        (hex.length == 7 ? 0xff000000 : 0x00000000),
  );
}

class ColorConstants {
  static Color main_Background = hexToColor('#F6FAFF');
  static Color primary_color = hexToColor('#0094FF');
  static Color kPrimaryColor = hexToColor('#0094FF');
  static Color kSectionHeadingColor = hexToColor('#7D929D');
  static Color kSecondaryColor1 = hexToColor('#FF3F3F');
  static Color kSecondaryColor2 = hexToColor('#50C2C9');
  static Color kSecondaryColor3 = hexToColor('#F79124');
  static Color klightGray = hexToColor('#D9D9D9');
  static Color myBlack = hexToColor('#000000');
  static Color lightGray = hexToColor('#AFBCC3');
  static Color lightGreen = hexToColor('#32B67A');
  static Color myRed = hexToColor('#FF0202');
  static Color myWhite = hexToColor('#ffffff');
}
