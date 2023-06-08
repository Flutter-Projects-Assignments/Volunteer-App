import 'package:donor_app/constants.dart';
import 'package:donor_app/Screens_volunteer/login_signup/signup.dart';
import 'package:donor_app/Screens_volunteer/login_signup/verify_phone.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPhone extends StatefulWidget {
  const RegisterPhone({Key? key}) : super(key: key);
  static const id = 'register_phone';
  static String verify = '';

  @override
  State<RegisterPhone> createState() => _RegisterPhoneState();
}

class _RegisterPhoneState extends State<RegisterPhone> {
  final _auth = FirebaseAuth.instance;

  TextEditingController countryController = TextEditingController();
  var phone = '';
  // late String _userId='';

  final error = SnackBar(
    content: Text(
      'Something went wrong. Try Again!',
      style: kTextStlye(FontWeight.w500, 14, Colors.red),
    ),
    backgroundColor: Colors.black.withOpacity(0.6),
    duration: Duration(seconds: 4),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(16),
    padding: EdgeInsets.all(20),
  );

  @override
  void initState() {
    super.initState();
    countryController.text = "+92";
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   _userId = ModalRoute.of(context)?.settings.arguments as String;
    // });
  }

  void verifyPhone(BuildContext context) async {
    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: countryController.text + phone,
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException e) {
          if (e.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) {
          RegisterPhone.verify = verificationId;
          // passing arguments to next screen
          Navigator.pushNamed(
            context,
            VerifyPhone.id,
            arguments: [countryController.text + phone],
          );
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (String verificationId) {},
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(20),
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    SizedBox(),
                    Image(
                      image: AssetImage('images/Sabeel_logo.png'),
                      width: 40,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                Text(
                  "phone_verification".tr(),
                  style: kTextStlye(FontWeight.bold, 22, kTextColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "phone_description".tr(),
                  style: kTextStlye(FontWeight.normal, 14, kTextColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          style: kTextStlye(
                              FontWeight.normal, 14, kSectionHeadingColor),
                          controller: countryController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextField(
                            style: kTextStlye(
                                FontWeight.normal, 14, kSectionHeadingColor),
                            keyboardType: TextInputType.phone,
                            onChanged: (value) {
                              phone = value;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "enter_phone".tr(),
                            ),
                          ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        verifyPhone(context);
                      },
                      child: Text(
                        "send_code".tr(),
                        style:
                        kTextStlye(FontWeight.bold, 16, kBackgroundColor),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
