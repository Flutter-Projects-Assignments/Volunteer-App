// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../Beneficiary/register_beneficiary.dart';
import '../Beneficiary/verify_beneficiary.dart';
import '../Constants/Colors.dart';
import '../Screens_volunteer/calendar.dart';
import '../Screens_volunteer/select_language.dart';
import '../home_volunteer.dart';
import '/History/history_item.dart';

class History extends StatelessWidget {

  static const id = 'history';
  String phonenumber;
  History({required this.phonenumber}): super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'history'.tr(),style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
      ),backgroundColor: ColorConstants.main_Background,centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Container(
            //   height: 52,
            //   child: TextField(
            //     decoration: InputDecoration(
            //         border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(30),
            //           borderSide: BorderSide.none,
            //         ),
            //         fillColor: Colors.grey[200],
            //         filled: true,
            //         hintText: "search_benefit_received".tr(),
            //         hintStyle:
            //             kTextStlye(FontWeight.normal, 16, Color(0xffB2BEB5)),
            //         suffixIcon: Icon(Icons.search)),
            //   ),
            // ),
            // s
            HistoryItem(
              historyImage: "images/charity.png",
              historyName: "charity_var".tr(),
            ),
            HistoryItem(
              historyImage: "images/zakaat.png",
              historyName: "zakaat_var".tr(),
            ),
            HistoryItem(
              historyImage: "images/sadqah.png",
              historyName: "sadqah_var".tr(),
            ),
            HistoryItem(
              historyImage: "images/charity.png",
              historyName: "charity_var".tr(),
            ),
            HistoryItem(
              historyImage: "images/zakaat.png",
              historyName: "zakaat_var".tr(),
            ),
            HistoryItem(
              historyImage: "images/sadqah.png",
              historyName: "sadqah_var".tr(),
            ),
            HistoryItem(
              historyImage: "images/charity.png",
              historyName: "charity_var".tr(),
            ),
          ],
        ),
      ),
      drawer: Drawer(
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
    );
  }
}
