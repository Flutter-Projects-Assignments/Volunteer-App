
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:donor_app/Beneficiary/register_beneficiary.dart';
import 'package:donor_app/Screens_volunteer/volunteersNeeded.dart';
import 'package:translator/translator.dart';
import '../../../Constants/Colors.dart';
import 'package:donor_app/Screens_volunteer/select_language.dart';

import 'package:location/location.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:donor_app/constants.dart';
//import '../../models/campaign.dart';
import 'package:donor_app/widgets/bottom_button_card.dart';
//import '../../widgets/donation_payment_template.dart';
//import 'package:donor_app/dummy_data.dart';
final _firestore = FirebaseFirestore.instance;

class CampaignAllTasks extends StatefulWidget {

  @override
  State<CampaignAllTasks> createState() => CampaignAllTaskState();
}

class  CampaignAllTaskState extends State<CampaignAllTasks> {
  late int _selectedRadio = -1;


  @override
  void initState() {
    _selectedRadio = -1;
    // if (SelectLanguage.isEng == false) {
    //   translateData();
    // }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   // print(widget.taskDetails['campaignDescription']);
    return Scaffold(
      appBar: kAppBar("camp_details".tr()),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('CampaignTask')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              final CampTask = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: CampTask.length,
                    itemBuilder: (context, index) {
                      final camp_task =
                      CampTask[index].data() as Map<String, dynamic>;

                      return Column(
                        children: [
                          CampaignTaskCard(
                            camp_task: camp_task,
                            index: index,
                            snapshot: snapshot,
                            amount: "${camp_task['amount'] ?? ''}",
                            desc: "${camp_task['campaignDescription'] ?? ''}",
                            heading: "${camp_task['campaignHeading'] ?? ''}",
                            daddress: "${camp_task['donorAddress'] ?? ''}",
                            donorPhonenumber: "${camp_task['donorPhonenumber'] ??
                                ''}",
                            //imagePath: "${camp_task['img'] ?? ''}",
                          ),
                        ],
                      );
                    }),
              );
            } else {
              return Center(
                child: Text('No data available'),
              );
            }
          }),
    );
  }
}
class CampaignTaskCard extends StatefulWidget{
  dynamic camp_task;
  late int index;
  dynamic snapshot;
  String amount = "";
  String heading = "";
  String desc = "";
  //String imagePath = "";
  String daddress = "";
  String donorPhonenumber ="";

  CampaignTaskCard(
      {required this.amount,
        required this.heading,
        required this. index,
        required this. snapshot,
        required this.desc,
        //required this.imagePath,
        required this.daddress,
        required this.donorPhonenumber, required this.camp_task,
      });
  @override
  State<CampaignTaskCard> createState() => CampaignTaskCardState();
}
class  CampaignTaskCardState extends State<CampaignTaskCard> {

  dynamic translatedData = {
    //"desc": "",
    "heading": "",
    "daddress": "",
  };

   Future<void> translateData() async {
     final translator = GoogleTranslator();

     final heading = await translator.translate(
         widget.heading,
         from: 'en',
         to: 'ur');
     final daddress = await translator
         .translate(widget.daddress, from: 'en', to: 'ur');

     setState(() {
       translatedData = {
         //"desc": desc.text,
         "daddress": daddress.text,
         "heading": heading.text,
         //"dnumber": dnumber.text,
       };
     });

   }

  Future<void> removeTask(snapshot, index) async{
    await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
      await myTransaction.delete(snapshot.data.docs[index].reference);
    });
  }
  @override
  void initState() {
    if (SelectLanguage.isEng == false) {
      translateData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //print("image path $imagePath");
    return Container(
      // height: 200,
      padding: const EdgeInsets.all(5),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.white),
      child: Row(
        children: [
          SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                SelectLanguage.isEng ? widget.camp_task['campaignHeading']:
                translatedData['heading'],
                style: kTextStlye(FontWeight.w600, 18, kTextColor ),
              ),
              SizedBox(height: 10),
              Text(
                "details".tr(),
                style: kTextStlye(FontWeight.w600, 18, kPrimaryColor),
              ),
              // Text(desc,
              //       style: TextStyle(
              //         fontSize: 16,
              //       ),softWrap: true,overflow: TextOverflow.fade,),
              SizedBox(
                height: 10
              ),
              Row(
                children: [
                  Text("amount_var".tr() + ":  ",
                      style: kTextStlye(FontWeight.w600, 18, kPrimaryColor)),
                  Text( "${'rs'.tr()} ${widget.amount}",
                      style: TextStyle(
                        fontSize: 16,
                      )),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "donor_details".tr(),
                style: kTextStlye(FontWeight.w600,18, kTextColor),
              ),
              Row(
                children: [
                  Text("address_var".tr() + ":  ",
                      style: kTextStlye(FontWeight.w600, 18, kPrimaryColor)),
                  Text(SelectLanguage.isEng ? widget.camp_task['donorAddress']:
                      translatedData['daddress'],
                      style: kTextStlye(FontWeight.w500, 18, kTextColor
                      )),
                ],
              ),
              Row(
                children: [
                  Text("phone_num_var".tr() + ":  ",
                      style: kTextStlye(FontWeight.w600, 18, kPrimaryColor)),
                  Text(widget.donorPhonenumber,
                      style: TextStyle(
                        fontSize: 16,
                      )),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(width: 130,),
                  IconButton(onPressed:(){
                    removeTask(widget.snapshot,widget.index);
                  },
                    icon: Icon(Icons.check_circle_rounded,color: Colors.green,size: 50,), ),
                  SizedBox(height: 20,),
                 // IconButton(onPressed: (){}, icon: Icon(Icons.cancel,color: ColorConstants.kSecondaryColor1,size: 50,), ),

                ],),
              SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );

  }
}
