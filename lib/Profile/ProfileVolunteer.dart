// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Beneficiary/register_beneficiary.dart';
import '../Beneficiary/verify_beneficiary.dart';
import '../Constants/colors.dart';
import '../constants.dart';
import '../Screens_volunteer/calendar.dart';
import '../Screens_volunteer/select_language.dart';
import '../home_volunteer.dart';
import 'edit_profile.dart';

class Profile extends StatelessWidget {
  static const id = 'user_profile';
  String phonenumber;

  Profile({required this.phonenumber}): super();

  @override
  Widget build(BuildContext context) {
    // final dynamic userDetails = ModalRoute.of(context)?.settings.arguments;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            // iconTheme: IconThemeData(color: ColorConstants.myBlack),
            centerTitle: true,
            title: Text(
              'profile'.tr(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            backgroundColor: ColorConstants.main_Background,
           ),
        drawer: Drawer(
          backgroundColor: kTextColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Center(child: Text('Volunteer'.tr(), style: TextStyle(fontSize: 20),)),
              ),
              ListTile(
                leading: Icon(
                  Icons.home,
                ),
                title: const Text('Dashboard', style: TextStyle(fontSize: 16),),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home(phonenumber: phonenumber,)));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.account_box_rounded,
                ),
                title: const Text('Tasks', style: TextStyle(fontSize: 16),),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TasksUI(taskProgress: [])));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.app_registration,
                ),
                title: const Text('Register Beneficiary', style: TextStyle(fontSize: 16),),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => RegisterBeneficiary(phonenumber: phonenumber,)));
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.verified,
                ),
                title: const Text('Verify Beneficiary', style: TextStyle(fontSize: 16),),
                onTap: () {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => VerifyBeneficiary()));
                },
              ),
              //  ListTile(
              //   leading: Icon(
              //     Icons.edit,
              //   ),
              //   title: const Text('Edit Profile', style: TextStyle(fontSize: 16),),
              //   onTap: () {
              //     Navigator.push(
              //         context, MaterialPageRoute(builder: (context) => EditProfile()));
              //   },
              // ),
              ListTile(
                leading: Icon(
                  Icons.logout,
                ),
                title: const Text('Log Out', style: TextStyle(fontSize: 16),),
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, MaterialPageRoute(builder: (context) => SelectLanguage()) as String);
                },
              ),
            ],
          ),

        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("volunteer_profile".tr(),
                      style: kTextStlye(kMainFontWeight, 20, kTextColor)),
                  SizedBox(height: 10),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage("images/flood.jpg"),
                  ),
                  SizedBox(height: 10),
                  Text("${"welcome".tr()}" ,
                      style: kTextStlye(FontWeight.w500, 18, kPrimaryColor)),
                  SizedBox(height:10),
                  Text("user".tr() ,
                      style: kTextStlye(FontWeight.w500, 18, kPrimaryColor)),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column
              (
                 children: [
                   SizedBox(height: 30),
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Info(
                         icon: Icon(Icons.circle, color: kLightGray),
                         title: "gender".tr(),
                         value: 'female'.tr(),
                       ),
                     ],
                   ),
                   SizedBox(height: 30),
                   Info(
                     icon: Icon(Icons.circle, color: kLightGray),
                     title: "CNIC".tr(),
                     value: '36302-1234567-0',
                   ),
                  SizedBox(height: 20),
                  Divider(color: kLightGray, thickness: 1),
                   SizedBox(height: 20),
                   Info(
                     icon: Icon(Icons.circle, color: kLightGray),
                     title: "email_address".tr(),
                     value: 'fzahid@gmail.com',
                   ),
                   SizedBox(height: 30),
                   Info(
                     icon: Icon(Icons.circle, color: kLightGray),
                     title: "phone_number".tr(),
                     value: '+921116382122',
                   ),
                   SizedBox(height: 30),
                   Info(
                    icon: Icon(Icons.circle, color: kLightGray),
                     title: "address".tr(),
                     value: 'new_address'.tr(),
                  ),
                   SizedBox(height: 30),
                   // TextButton(
                   //   onPressed: () {
                   //    Navigator.push(
                   //        context,
                   //         MaterialPageRoute(builder: (context) => EditProfile(), settings: RouteSettings(arguments: userDetails)));
                   //   },
                   //   child: Text('edit_details'.tr(), style: TextStyle(fontSize: 16),),
                   //   style: TextButton.styleFrom(
                   //     primary: Colors.white,
                   //     backgroundColor: Colors.blue,
                   //   ),
                   // ),
                 ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Info extends StatelessWidget {
  Icon icon = Icon(Icons.circle, color: kLightGray);
  String title = "";
  String value = "";

  Info({Key? key, required this.icon, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: kTextStlye(FontWeight.normal, 18, Colors.black)),
            Text(value, style: kTextStlye(kMainFontWeight, 18, Colors.black)),
          ],
        )
      ],
    );
  }
}
