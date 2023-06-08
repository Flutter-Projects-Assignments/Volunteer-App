import 'package:flutter/material.dart';

import 'Screens_volunteer/select_language.dart';

const google_api_key = "AIzaSyB6drpTDnKWppK7gn7E4cbgjOAs1eMswas";

const kTextColor = Color(0xff002636);
const kPrimaryColor = Color(0xff0094FF);
const kSectionHeadingColor = Color(0xff7D929D);
const kLightPrimaryColor = Color(0xffECF7FF);
const kSecondaryColor1 = Color(0xffFF3F3F);
const kSecondaryColor2 = Color(0xff50C2C9);
const kSecondaryColor3 = Color(0xffF79124);
const kBackgroundColor = Color(0xffF6FAFF);
const kCardColor = Color(0xffffffff);
const kLightGray = Color(0xffD9D9D9);

const kScreenPadding = 16.0;

const kMainHeadingSize = 18.0;
const kMainFontWeight = FontWeight.bold;

TextStyle kTextStlye(FontWeight weight, double size, Color color) {
  return TextStyle(
    color: color,
    fontFamily: SelectLanguage.isEng ? 'Inter' : 'Nastaleeq',
    fontWeight: weight,
    fontSize: SelectLanguage.isEng ? size : size + 5,
  );
}

AppBar kAppBar(String text) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    centerTitle: true,
    title: Text(
      text,
      style: kTextStlye(FontWeight.w600, 20, kBackgroundColor),
    ),
    // leading: const Icon(Icons.menu),
  );
}
