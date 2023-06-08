import 'dart:async';
import '../login.dart';
import '../../select_language.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, SelectLanguage.id);
    });
  }
}
