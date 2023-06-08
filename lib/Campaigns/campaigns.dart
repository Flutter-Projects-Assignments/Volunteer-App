import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:donor_app/Beneficiary/register_beneficiary.dart';
import 'package:donor_app/Screens_volunteer/volunteersNeeded.dart';
import '../../../Constants/Colors.dart';
import 'CampaignTask.dart';
import 'package:location/location.dart';
import 'Camp_allTasks.dart';


class CampaignsTaskCard extends StatelessWidget {
  String phonenumber;
  CampaignsTaskCard({required this.phonenumber}): super();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('CampaignTask')
            .limit(1)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final CampTask = snapshot.data!.docs;
            final camp_task = CampTask[0].data() as Map<String, dynamic>;
            //print("img ${camp_task['img']}");
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0,),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "camptask".tr(),
                        style:
                        TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        CampaignAllTasks()));
                          }, child: Text("view_all".tr()))
                    ],
                  ),
                  // SizedBox(height: 10),
                    CampaignTaskCard(
                      camp_task: camp_task,
                      amount: "${camp_task['amount'] ?? ''}",
                      desc: "${camp_task['campaignDescription'] ?? ''}",
                      heading: "${camp_task['campaignHeading'] ?? ''}",
                      daddress: "${camp_task['donorAddress'] ?? ''}",
                      donorPhonenumber: "${camp_task['donorPhonenumber'] ?? ''}",
                      //imagePath: "${camp_task['img'] ?? ''}",
                  ),
                ],
              ),
            );
          } else {
            return Center(
              child: Text('No data available'),
            );
          }
        });
  }
}
  class CampaignTaskCard extends StatelessWidget{
    dynamic camp_task;
    String amount = "";
    String heading = "";
    String desc = "";
    //String imagePath = "";
    String daddress = "";
    String donorPhonenumber ="";


    CampaignTaskCard(
    {required this.amount,
    required this.heading,
    required this.desc,
    //required this.imagePath,
    required this.daddress,
    required this.donorPhonenumber, required this.camp_task,
    });

    @override
    Widget build(BuildContext context) {
      //print("image path $imagePath");
    return InkWell(
      onTap: (){
        print(camp_task);
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => CampaignTask(
          taskDetails: camp_task,
          //donorPhonenumber: donorPhonenumber,
        ),
        ));
      },
      child: Container(
          height: 250,
          width: double.infinity,
          decoration: BoxDecoration(
          color: ColorConstants.primary_color,
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
          image: AssetImage("images/flood.jpg"),
          fit: BoxFit.fill,
          )),
            child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Text(heading,
                  style: kTextStlye(
                  FontWeight.bold, 14, ColorConstants.myWhite)),

      ],
      ),

      ]),
            )
      ),
    );

    }

    }