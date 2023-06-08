// ignore_for_file: unused_field

import 'package:donor_app/Screens_volunteer/login_signup/login.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../home_volunteer.dart';
import './login_signup/login.dart';
import 'landing_page.dart';

class SelectLanguage extends StatefulWidget {
  const SelectLanguage({Key? key}) : super(key: key);
  static const id = "select_language";
  static bool isEng = true;

  @override
  State<SelectLanguage> createState() => _SelectLanguageState();
}

class _SelectLanguageState extends State<SelectLanguage> {
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    stopLoading();
  }

  void stopLoading() {
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Container(
          color: kBackgroundColor,
          margin: EdgeInsets.only(left: 20, right: 20, top: 20),
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Image(
                  image: AssetImage('images/Sabeel_logo.png'),
                  width: 100,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            context.locale = Locale('en', 'US');
                            SelectLanguage.isEng = true;
                          },
                          child: const Text("English",
                              style: TextStyle(
                                color: kBackgroundColor,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              )),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 40,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: kLightPrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            context.locale = Locale('en', 'PK');
                            SelectLanguage.isEng = false;
                          },
                          child: Text(
                            "اردو",
                            style: kTextStlye(FontWeight.w600,
                                SelectLanguage.isEng ? 16 : 20, kPrimaryColor),
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => LandingPage()));
                      },
                      child: Row(
                        children: [
                          Text(
                            "next".tr(),
                            style: kTextStlye(FontWeight.w500,
                                SelectLanguage.isEng ? 16 : 18, kTextColor),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text("->",
                              style: TextStyle(
                                color: kTextColor,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              )),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
