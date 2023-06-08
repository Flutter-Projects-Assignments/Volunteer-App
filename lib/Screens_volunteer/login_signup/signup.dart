import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/constants.dart';
import 'package:donor_app/models/database.dart';
import '../../home_volunteer.dart';
import './models/user_model.dart';
import 'register_phone.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get/get_core/src/get_main.dart';
import '../../widgets/input_textfield.dart';
import './../../navigation/navigation_bar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:donor_app/Screens_volunteer/VolunteerDashboard.dart';

final _firestore = FirebaseFirestore.instance;

class SignUpCredentials extends StatefulWidget {
  static const id = 'signup';

  @override
  State<SignUpCredentials> createState() => _SignUpCredentialsState();
}

class _SignUpCredentialsState extends State<SignUpCredentials> {
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  late final credential;

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _cnicController = TextEditingController();
  late String _phonenumber;
  late String password;
  late String _userId;
  late String _name;
  late String cnic;

  late String email;
  Database db = Database();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final args = ModalRoute.of(context)?.settings.arguments as String;
      _phonenumber = args;


      // db.setUser(_userId);
    });
  }

  /// Check if there is a signed in user
  void getCurrentUser() {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.phoneNumber);
      }
    } catch (e) {
      print(e);
    }
  }

  void createUser() async {
    UserModel user = UserModel(
      fullName: _name,
      password: password,
      phonenumber: _phonenumber,
      cnic: cnic,
      // age: 0,
      // address: "",
      // city: "",
      // gender: ""
    );

    await db.addUser(user: user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
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
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: kTextColor,
                        )),
                    const SizedBox(),
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
                  "signup".tr(),
                  style: kTextStlye(FontWeight.bold, 20, kTextColor),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "signup_description".tr(),
                  style: kTextStlye(FontWeight.w500, 14, kTextColor),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                InputTextField(
                  icon: const Icon(Icons.person_outline_outlined),
                  controller: _usernameController,
                  hintText: "enter_name".tr(),
                  keyboardType: TextInputType.text,
                  hideText: false,
                  onChanged: (value) {
                    _name = value;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                InputTextField(
                  icon: const Icon(Icons.credit_card_rounded),
                  controller: _cnicController,
                  hintText: "enter_cnic".tr(),
                  keyboardType: TextInputType.text,
                  hideText: false,
                  onChanged: (value) {
                    cnic = value;
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                InputTextField(
                    icon: const Icon(Icons.lock_outline_rounded),
                    controller: _passwordController,
                    hintText: "enter_password".tr(),
                    keyboardType: TextInputType.text,
                    hideText: true,
                    onChanged: (value) {
                      password = value;
                    }),
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
                        createUser();
                        Navigator.push(
                        context, MaterialPageRoute(builder: (context) => Home(phonenumber:_phonenumber,)));
                        },
                      child: Text(
                        "signup".tr(),
                        style:
                            kTextStlye(FontWeight.bold, 16, kBackgroundColor),
                      )),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
