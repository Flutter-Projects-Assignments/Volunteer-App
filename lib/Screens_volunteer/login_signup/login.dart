import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/constants.dart';
import 'package:donor_app/models/Voldatabase.dart';

import 'package:donor_app/Screens_volunteer/login_signup/register_phone.dart';
import 'package:flutter/material.dart';
import '../../widgets/input_textfield.dart';
import 'models/user_model.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:donor_app/home_volunteer.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'login';
  static String verify = '';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  /// To make sure the text fields aren't empty
  final _key = GlobalKey<FormState>();
  VolDatabase VolunteerDatabase =   VolDatabase();

  TextEditingController countryController = TextEditingController();
  final _phonenumberController = TextEditingController();
  final _passwordController = TextEditingController();

  late UserModel VolunteerDetails;
  late final user;
  late String _phonenumber;
  late String _password;
  //late String _userId;

  Color borderColor = kPrimaryColor;
  bool _saving = false;
  bool _passwordVisible = false;

  final error = SnackBar(
    content: Text(
      'An Error Occurred. Try Again',
      textAlign: TextAlign.center,
      style: kTextStlye(FontWeight.w500, 16, Colors.white),
    ),
    backgroundColor: Colors.redAccent.withOpacity(0.5),
    duration: const Duration(seconds: 3),
  );
  final notVerified = SnackBar(
    content: Text(
      'You cannot login.Not Verified yet!',
      textAlign: TextAlign.center,
      style: kTextStlye(FontWeight.w500, 16, Colors.white),
    ),
    backgroundColor: Colors.redAccent.withOpacity(0.5),
    duration: const Duration(seconds: 3),
  );
  final incorrectPassword = SnackBar(
    content: Text(
      'Incorrect Password!',
      textAlign: TextAlign.center,
      style: kTextStlye(FontWeight.w500, 16, Colors.white),
    ),
    backgroundColor: Colors.redAccent.withOpacity(0.5),
    duration: const Duration(seconds: 3),
  );
  final incorrectPhonenumber = SnackBar(
    content: Text(
      'Incorrect Phone Number',
      textAlign: TextAlign.center,
      style: kTextStlye(FontWeight.w500, 16, Colors.white),
    ),
    backgroundColor: Colors.redAccent.withOpacity(0.5),
    duration: const Duration(seconds: 3),
  );

  @override
  void initState() {
    super.initState();
    countryController.text = "+92";

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   // final args = ModalRoute.of(context)?.settings.arguments as String;
    //   //_userId = args;
    //   //print("userid $_userId");
    //   //db.setUser(_userId);
    //   // VolunteerDatabase.setUser(_userId);
    // });
  }

  /// Checks if password is correct
  bool isVolunteerPasswordCorrect(UserModel user) {
    print("password ${user.password}");
    if (user.password == _password) {
      return true;
    } else {
      return false;
    }
  }

  /// Get User data from database and Applies all checks for validation
  void validateVolunteer() async {
    // Check if phone  number digits are equal to 10 excluding starting '0'
    print("phonenumber ${_phonenumber}");

    if (_phonenumber.length < 10 || _phonenumber.length > 10) {
      ScaffoldMessenger.of(context).showSnackBar(incorrectPhonenumber);
    } else {
      // get user details from the database
      print(countryController.text + _phonenumber);
      VolunteerDetails =
      (await getuserDetails(countryController.text + _phonenumber))!;
      //print("User id ${_userId}");
      print(VolunteerDetails);
      print(VolunteerDetails.phonenumber);
      print(VolunteerDetails.password);
      if (VolunteerDetails.phonenumber == "") {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(incorrectPhonenumber);
        }
      } else if (VolDatabase.message == 'Error fetching user') {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(error);
        }
      } else {
        // Check if the password is correct
        if (!isVolunteerPasswordCorrect(VolunteerDetails)) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(incorrectPassword);
          }
        } else {
          if (context.mounted) {
            Navigator.push(context, MaterialPageRoute(builder: (context) => Home(phonenumber:
            _phonenumber)));

          }
        }
      }
    }
  }

  /// Gets User details whose phone number matches
  Future<UserModel?> getuserDetails(String phonenumber) async {
    setState(() {
      _saving = true;
    });
    final userData = await VolunteerDatabase.getUser(phonenumber);
    setState(() {
      _saving = false;
    });
    return userData;
  }

  bool isBeneficiaryPasswordCorrect(UserModel user) {
    print("password ${user.password}");
    if (user.password == _password) {
      return true;
    } else {
      return false;
    }
  }

  /// Get User data from database and Applies all checks for validation
  void validateBeneficiary() async {
    // Check if phone  number digits are equal to 10 excluding starting '0'
    print("beneficiary phonenumber ${_phonenumber}");

    if (_phonenumber.length < 10 || _phonenumber.length > 10) {
      ScaffoldMessenger.of(context).showSnackBar(incorrectPhonenumber);
    } else {
      // get user details from the database
      print(countryController.text + _phonenumber);
      VolunteerDetails =
      (await getVolunteerDetails(countryController.text + _phonenumber))!;
      //print("User id ${_userId}");
      print(VolunteerDetails.id);
      print(VolunteerDetails.phonenumber);
      print(VolunteerDetails.password);
      if (VolunteerDetails.phonenumber == "") {
        // print("Yahan aya");
        if (context.mounted) {
          print("Yahan aya!!");
          ScaffoldMessenger.of(context).showSnackBar(incorrectPhonenumber);
        }
      } else if (VolDatabase.message == 'Error fetching user') {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(error);
        }
      } else {
        // Check if the password is correct
        if (!isBeneficiaryPasswordCorrect(VolunteerDetails)) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(incorrectPassword);
          }
        } else {
          if (context.mounted) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home(phonenumber: _phonenumber,)));
          }
        }
      }
    }
  }

  /// Gets User details whose phone number matches
  Future<UserModel?> getVolunteerDetails(
      String phonenumber) async {
    print(phonenumber);
    setState(() {
      _saving = true;
    });
    final userData = await VolunteerDatabase.getUser(phonenumber);
    setState(() {
      _saving = false;
    });
    return userData;
  }

  @override
  Widget build(BuildContext context) {
    // User? user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: _saving,
        child: Form(
          key: _key,
          child: SafeArea(
            child: Container(
                margin: const EdgeInsets.all(20.0),
                alignment: Alignment.topCenter,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.arrow_back_ios,
                              color: kTextColor,
                            ),
                            iconSize: 20,
                            constraints: const BoxConstraints(),
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                          const Image(
                            image: AssetImage('images/Sabeel_logo.png'),
                            width: 40,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Text(
                        "login".tr(),
                        style: kTextStlye(FontWeight.bold, 20, kTextColor),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "login_description".tr(),
                        style: kTextStlye(FontWeight.w500, 14, kTextColor),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      InputTextField(
                        icon: const Icon(Icons.phone),
                        controller: _phonenumberController,
                        hintText:
                        "${countryController.text} | ${"enter_phone".tr()}",
                        keyboardType: TextInputType.phone,
                        hideText: false,
                        onChanged: (value) {
                          _phonenumber = value;
                        },
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InputTextField(
                        icon: const Padding(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          child: Icon(Icons.lock_outline),
                        ),
                        controller: _passwordController,
                        hintText: "enter_password".tr(),
                        keyboardType: TextInputType.text,
                        hideText: _passwordVisible ? false : true,
                        suffix: IconButton(
                          constraints: const BoxConstraints(),
                          padding: EdgeInsets.zero,
                          icon: _passwordVisible
                              ? const Icon(Icons.visibility_outlined)
                              : const Icon(Icons.visibility_off_outlined),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        onChanged: (value) {
                          _password = value;
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: kPrimaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () async {
                              if (_key.currentState!.validate()) {
                                 validateVolunteer();
                              }
                            },
                            child: Text(
                              "login".tr(),
                              style: kTextStlye(
                                  FontWeight.bold, 16, kBackgroundColor),
                            )),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "no_account".tr(),
                            style:
                            kTextStlye(FontWeight.normal, 16, kTextColor),
                          ),
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => RegisterPhone()));
                              },
                              child: Text('signup'.tr()))
                        ],
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
