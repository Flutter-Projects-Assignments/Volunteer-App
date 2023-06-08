import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/Screens_volunteer/select_language.dart';
import 'package:donor_app/Screens_volunteer/track_location.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../Beneficiary/register_beneficiary.dart';
import '../Beneficiary/verify_beneficiary.dart';
import 'volunteersNeeded.dart';
import '../home_volunteer.dart';
// import 'VolunteerDashboard.dart';
import 'calendar.dart';

class VolunteerTask extends StatelessWidget {
  static const id = 'volunteer_task';
  String phonenumber;
  VolunteerTask({required this.phonenumber}): super();

  Future<String?> removeTask(snapshot, index) async{
    await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
      await myTransaction.delete(snapshot.data.docs[index].reference);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        appBar: AppBar(title: Text("available_tasks".tr()),centerTitle: true,),
        body: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('EnrolledTasks')
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {

                            return Center(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "no_task".tr(),
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    // TextButton(
                                    //   onPressed: () {
                                    //     Navigator.push(
                                    //         context,
                                    //         MaterialPageRoute(
                                    //             builder: (context) =>
                                    //                 VolunteersNeeded(phonenumber: phonenumber,)));
                                    //   },
                                    //   child: Text('explore_volunteering'.tr()),
                                    //   style: TextButton.styleFrom(
                                    //     foregroundColor: Colors.white, backgroundColor: Colors.blue, disabledForegroundColor: Colors.grey.withOpacity(0.38),
                                    //   ),
                                    // ),
                                  ],
                                ),
                              ),
                            );
                          } else if (snapshot.hasData) {

                            final AllTask = snapshot.data!.docs;
                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  itemCount: AllTask.length,
                                  itemBuilder: (context, index) {
                                    final task =
                                    AllTask[index].data() as Map<String, dynamic>;

                                    return  Column(
                                      children: [
                                        TaskCard(
                                            bname: "${task['bname'] ?? ''}",
                                            bnumber: "${task['bnumber'] ?? ''}",
                                            baddress: "${task['baddress'] ?? ''}",
                                            dnumber: "${task['dnumber'] ?? ''}",
                                            daddress: "${task['daddress'] ?? ''}",
                                            amount: "${task['amount'] ?? ''}",
                                          onPressed: ()async{
                                             await removeTask(snapshot, index);
                                          },
                                        ),
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    );
                                  }),
                            );
                          } else {
                            return Center(
                              child: Text('No data available'),
                            );
                          }
                        })
                        ),
                  );
                }

}

