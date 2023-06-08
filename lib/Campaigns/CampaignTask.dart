
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:donor_app/Beneficiary/register_beneficiary.dart';
import 'package:donor_app/Screens_volunteer/volunteersNeeded.dart';
import '../../../Constants/Colors.dart';
import 'package:translator/translator.dart';
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

class CampaignTask extends StatefulWidget {

  dynamic taskDetails;
  //String type;
  //int index;
  //AsyncSnapshot snapshot;

  CampaignTask({
    Key? key,
    required this.taskDetails,
    //required this.snapshot,
    //required this.index
  }) : super(key: key);

  @override
  State<CampaignTask> createState() => CampaignTaskState();
}

class  CampaignTaskState extends State<CampaignTask> {
  late int _selectedRadio = -1;
  dynamic translatedData = {
    "desc": "",
    "heading": "",
    "daddress": "",
  };

  Future<void> translateData() async {
    final translator = GoogleTranslator();

    final desc = await translator.translate(
        widget.taskDetails['campaignDescription'],
        from: 'en',
        to: 'ur');
    final daddress = await translator
        .translate(widget.taskDetails['donorAddress'], from: 'en', to: 'ur');
    final heading = await translator.translate(
        widget.taskDetails['campaignHeading'],
        from: 'en',
        to: 'ur');
    //
    // final illness = await translator.translate("yes", from: 'en', to: 'ur');
    // final disability = await translator.translate("no", from: 'en', to: 'ur');

    setState(() {
      translatedData = {
        "desc": desc.text,
        "daddress": daddress.text,
        "heading": heading.text,
        //"dnumber": dnumber.text,
      };
    });
  }

  @override
  void initState() {
    _selectedRadio = -1;
    if (SelectLanguage.isEng == false) {
      translateData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.taskDetails['campaignDescription']);
    return Scaffold(
      appBar: kAppBar("camp_details".tr()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: SelectLanguage.isEng ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 260,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: AssetImage("images/flood.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
            Text(
              translatedData['heading'],
                style: kTextStlye(FontWeight.w600, 20, ColorConstants.kPrimaryColor,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "amount_var".tr() + ":",
                style: kTextStlye(
                  FontWeight.w800,
                  16,
                  kTextColor,
              ),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                "rs".tr() + ". " + widget.taskDetails['amount'], style: kTextStlye(FontWeight.w600, 20, kSecondaryColor2),
              ),
              SizedBox(
                height: 20,
              ),

              Text(
                SelectLanguage.isEng ? widget.taskDetails['campaignDescription']:translatedData['desc'], style: kTextStlye(FontWeight.normal, 18, kTextColor),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "donor_phone".tr(),
                style: kTextStlye(
                  FontWeight.w800,
                  16,
                  kTextColor,),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                widget.taskDetails['donorPhonenumber'], style: kTextStlye(FontWeight.normal, 18, kTextColor),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "donor_address".tr(),
                style: kTextStlye(
                  FontWeight.w800,
                  16,
                  kTextColor,),
              ),
              Text(
                SelectLanguage.isEng ? widget.taskDetails['donorAddress']: translatedData['daddress'],
                style: kTextStlye(
                  FontWeight.w500,
                  18,
                  kTextColor,),
              ),
              SizedBox(
                width: 20,
              ),


            ],
          ),
  )
  )
  );
  }
}
//
// Text(
// "Donor Phone Number",
// style: kTextStlye(FontWeight.w500, 16, kTextColor),
// ),
// Text(
// widget.taskDetails['campaignDescription'],
// style: kTextStlye(FontWeight.normal, 16, kTextColor),
// ),