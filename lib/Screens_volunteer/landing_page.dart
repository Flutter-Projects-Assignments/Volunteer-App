// ignore_for_file: unused_field

import 'package:donor_app/Screens_volunteer/login_signup/login.dart';
import 'package:donor_app/Screens_volunteer/login_signup/register_phone.dart';
import 'package:donor_app/Screens_volunteer/login_signup/signup.dart';
import 'package:donor_app/Screens_volunteer/volunteersNeeded.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../home_volunteer.dart';
import './login_signup/login.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);
  static const id = "select_language";
  static bool isEng = true;

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
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
                              backgroundColor: kPrimaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {

                            Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));

                          },
                          child:  Text("login".tr(),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterPhone()));
                          },
                          child: Text(
                            "signup".tr(),
                            style: kTextStlye(FontWeight.w600,
                                 16, kPrimaryColor),
                          )),
                    )
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
