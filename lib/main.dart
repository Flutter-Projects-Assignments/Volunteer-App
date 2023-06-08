import 'package:donor_app/Screens_volunteer/login_signup/login.dart';
import 'package:donor_app/Screens_volunteer/login_signup/register_phone.dart';
import 'package:donor_app/Screens_volunteer/login_signup/verify_phone.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '/Screens_volunteer/select_language.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

import 'Screens_volunteer/login_signup/signup.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
        supportedLocales: [Locale('en', 'US'), Locale('en', 'PK')],
        path: 'translations',
        fallbackLocale: Locale('en', 'US'),
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Volunteer',
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        VerifyPhone.id:(context) => VerifyPhone(),
        RegisterPhone.id: (context) => RegisterPhone(),
        SignUpCredentials.id: (context) => SignUpCredentials(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SelectLanguage(),
    );
  }
}
