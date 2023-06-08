// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/Screens_volunteer/charity_beneficiaries.dart';
import 'package:donor_app/Screens_volunteer/select_language.dart';
import 'package:donor_app/Screens_volunteer/track_location.dart';
import 'package:donor_app/Screens_volunteer/volunteersNeeded.dart';
import 'package:donor_app/Screens_volunteer/zakat_beneficiaries.dart';
import 'package:donor_app/constants.dart';
import 'package:donor_app/widgets/card_style_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:donor_app/Beneficiary/register_beneficiary.dart';
import 'package:translator/translator.dart';
import '../../../Beneficiary/verify_beneficiary.dart';
import '../../../Constants/Colors.dart';
import '../../../Navigation/navigation_bar.dart';
import '../../../Profile/edit_profile.dart';
import '../../../widgets/enrolledTaskCard.dart';
import '../../../widgets/vncard.dart';
import '../home_volunteer.dart';
import 'TaskCard.dart' as tc;
import 'calendar.dart';
import 'package:location/location.dart';
import 'package:donor_app/Campaigns/campaigns.dart';

import 'sadaqa_beneficiaries.dart';

class VolunteerDashboard extends StatelessWidget {

  String phonenumber;
  VolunteerDashboard({required this.phonenumber}): super();
  void getCurrentLocation(){
    Location location = Location();
    location.getLocation().then(
        (location) async {
          print('Location is: ${location.latitude} and ${location.longitude}');
        }
    );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: ColorConstants.myBlack),
          centerTitle: true,
          title: Text(
            'volunteer_dashboard'.tr(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: ColorConstants.main_Background,
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: SvgPicture.asset('images/icons/notifications.svg'),
                ))
          ]),
      drawer: 
      Drawer(
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
              title:  Text('home_dashboard'.tr(), style: TextStyle(fontSize: 16),),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Home(phonenumber: phonenumber,)));
              },
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.account_box_rounded,
            //   ),
            //   title: const Text('Tasks', style: TextStyle(fontSize: 16),),
            //   onTap: () {
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => TasksUI(taskProgress: [])));
            //   },
            // ),
            ListTile(
              leading: Icon(
                Icons.app_registration,
              ),
              title:  Text("reg_beneficary".tr(), style: TextStyle(fontSize: 16),),
              onTap: () {
               Navigator.push(
                    context, MaterialPageRoute(builder: (context) => RegisterBeneficiary(phonenumber: phonenumber,)));
              },
            ),
            // ListTile(
            //   leading: Icon(
            //     Icons.verified,
            //   ),
            //   title: const Text('Verify Beneficiary', style: TextStyle(fontSize: 16),),
            //   onTap: () {
            //     Navigator.push(
            //         context, MaterialPageRoute(builder: (context) => VerifyBeneficiary()));
            //   },
            // ),
             ListTile(
              leading: Icon(
                Icons.more_time_sharp,
              ),
              title: Text("schedule".tr(), style: TextStyle(fontSize: 16),),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => TasksUI(taskProgress: [20,30,40,10,40,70,60])));
              },
            ),
            ListTile(
              leading: Icon(
                Icons.logout,
              ),
              title: Text('logout'.tr(), style: TextStyle(fontSize: 16),),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, MaterialPageRoute(builder: (context) => SelectLanguage()) as String);
              },
            ),
          ],
        ),
        
      ),
      body:
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('VolunteerTask')
                          .limit(1)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasData) {
                          final AllTask = snapshot.data!.docs;
                          final task = AllTask[0].data() as Map<String, dynamic>;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0,),
                            child: Column(

                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "volunteers_needed".tr(),
                                            style:
                                            TextStyle(color: Colors.grey, fontSize: 16),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => VolunteersNeeded(phonenumber: phonenumber,)));
                                              }, child: Text("view_all".tr()))
                                        ],
                                      ),
                                      // SizedBox(height: 10),
                                      tc.TaskCard(
                                        bname: "${task['bname'] ?? ''}",
                                        bnumber: "${task['bnumber'] ?? ''}",
                                        baddress: "${task['baddress'] ?? ''}",
                                        dnumber: "${task['dnumber'] ?? ''}",
                                        daddress: "${task['daddress'] ?? ''}",
                                        amount: "${task['amount'] ?? ''}",
                                      ),

                                    ],
                                  ),
                          );
                        } else {
                          return Center(
                            child: Text('No data available'),
                          );
                        }
                      }),

                  const SizedBox(height: 20),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterBeneficiary(phonenumber: phonenumber,)));
                    },
                    child: VNCard(
                      title: "reg_beneficary".tr(),
                      iconPath: "images/zakat.png",
                      location: "islamabad".tr(),
                      volunteersNeeded: 5,
                      width: 40,
                    ),
                  ),
                  const SizedBox(height: 10),

      Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            CardHeading(
              heading: "ver_ben".tr(),
            ),
            SizedBox(
                height: 40,
                child: ListView(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                children: [
                CategoryButton(
                    width: 100,
                    label: "zakaat_var".tr(),
                    color: kPrimaryColor,
                    onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ZakatBeneficiaries(
                      //donorPhonenumber: phonenumber
              )));
              },
              ),
                CategoryButton(
                  width: 100,
                  color: kSecondaryColor3,
                  label: "sadqah_var".tr(),
                  onPressed: () {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SadaqaBeneficiaries(
                    //donorPhonenumber: phonenumber
                    )));
              },
              ),
                  CategoryButton(
                    width: 100,
                    color: kSecondaryColor1,
                    label: "charity_var".tr(),
                    onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CharityBeneficiaries(
                      //donorPhonenumber: phonenumber
              ),),);
              },
            ),

            ]),
            ),
            const SizedBox(
              height: 15,
            ),
            CampaignsTaskCard(phonenumber: phonenumber),
    ],
    ),
    ])
    ),
          ));
  }
}




class CategoryButton extends StatelessWidget {
  Color color;
  String label;
  double width;
  Function()? onPressed;

  CategoryButton(
      {required this.width,
        required this.color,
        required this.label,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            primary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: EdgeInsets.all(0),
          ),
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: const Alignment(-0.9, 2),
                  colors: [
                    color.withOpacity(0.3),
                    color,
                    color,
                  ]),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            child: Container(
              constraints: BoxConstraints(maxWidth: width, maxHeight: 40),
              alignment: Alignment.center,
              child: Text(
                label,
                style: kTextStlye(FontWeight.bold, 12, Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
