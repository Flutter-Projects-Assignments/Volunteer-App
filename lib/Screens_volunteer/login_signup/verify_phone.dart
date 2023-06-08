import 'package:donor_app/constants.dart';
import 'package:donor_app/navigation/navigation_bar.dart';
import 'package:donor_app/Screens_volunteer/VolunteerDashboard.dart';
import 'package:donor_app/Screens_volunteer/login_signup/register_phone.dart';
import 'package:donor_app/Screens_volunteer/login_signup/signup.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class VerifyPhone extends StatefulWidget {
  static const id = 'verify_phone';

  VerifyPhone();
  @override
  State<VerifyPhone> createState() => _VerifyPhoneState();
}

class _VerifyPhoneState extends State<VerifyPhone> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var code = '';
  String errMsg = '';

  late String _phone;
  // late String _userId;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final args = ModalRoute.of(context)?.settings.arguments as List;
      _phone = args[0];
      // _userId = args[1];
    });
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 22,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    void verifyOtp(BuildContext context, String userOtp) async {
      try {
        PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: RegisterPhone.verify, smsCode: code);

        // Sign the user in (or link) with the credential
        final newUser = await auth.signInWithCredential(credential);

        if (context.mounted) {
          Navigator.pushNamed(
            context,
            SignUpCredentials.id,
            arguments: _phone,
          );
        }
      } catch (e) {
        setState(() {
          errMsg = "code_invalid".tr();
        });
      }
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
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
                style: const TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                onChanged: (value) {
                  code = value;
                },
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                showCursor: true,
                onCompleted: (pin) => print(pin),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),
                  Text(
                    errMsg,
                    style: kTextStlye(FontWeight.bold, 12, Colors.red),
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      verifyOtp(context, code);
                    },
                    child: Text(
                      "verify".tr(),
                      style: kTextStlye(FontWeight.bold, 16, kBackgroundColor),
                    )),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () async {
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: _phone,
                          verificationCompleted:
                              (PhoneAuthCredential credential) {
                            // auth.signInWithPhoneNumber(credential.toString());
                          },
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            RegisterPhone.verify = verificationId;
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                        setState(() {
                          errMsg = '';
                          code = '';
                        });
                      },
                      child: Text(
                        "resend_code".tr(),
                        style: kTextStlye(FontWeight.w600, 16, kTextColor),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
