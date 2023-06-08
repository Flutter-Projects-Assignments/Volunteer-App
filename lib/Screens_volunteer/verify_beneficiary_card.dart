//import 'package:donor_app/Screens_volunteer/donate_money/select_payment_method.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../constants.dart';
import '../widgets/card_style_widget.dart';
import 'donate_for_beneficiary.dart';
import "package:donor_app/Screens_volunteer/select_language.dart";

class VerifyBeneficiaryCard extends StatefulWidget {
  // String guardianName;
  // String guardianCnic;
  // bool isSoleProvider;
  // String monthlyIncome;
  // int noOfDependents;
  // String phonenumber;
  // String requestedAmount;
  // String dependentAge;
  // String dependentName;
  // int dependentNumber;
  // String dependentRelation;
  // String disabilityDesc;
  // bool hasDisability;
  // bool hasHealthConditions;
  // bool liveTogether;
  // String healthConditionDesc;
  // String address;
  // int beneficiaryAge;
  String type;
  dynamic beneficiaryDetails;
  int index;
  AsyncSnapshot snapshot;


  VerifyBeneficiaryCard({Key? key,
    required this.beneficiaryDetails,
    required this.type,
    required this.index,
    required this.snapshot})
      : super(key: key);
  @override
  State<VerifyBeneficiaryCard> createState() => VerifyBeneficiary();
}
  class VerifyBeneficiary extends State<VerifyBeneficiaryCard> {
  dynamic translatedData = {
    "name": "",
    "address": "",
  };

  Future<void> translateData() async {
    final translator = GoogleTranslator();

    final name = await translator.translate(
        widget.beneficiaryDetails['guardianName'],
        from: 'en',
        to: 'ur');
    final address = await translator
        .translate(widget.beneficiaryDetails['address'], from: 'en', to: 'ur');
    // final heading = await translator.translate(
    //     widget.taskDetails['campaignHeading'],
    //     from: 'en',
    //     to: 'ur');
    //
    // final illness = await translator.translate("yes", from: 'en', to: 'ur');
    // final disability = await translator.translate("no", from: 'en', to: 'ur');

    setState(() {
      translatedData = {
        "name": name.text,
        "address": address.text,
      };
    });
  }

  @override
  void initState() {
    // _selectedRadio = -1;

    if (SelectLanguage.isEng == false) {
      translateData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NewCard(
      cardHeight: 300,
      widget: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    SelectLanguage.isEng ? widget.beneficiaryDetails['guardianName']:translatedData['name'] ?? '',
                    style: kTextStlye(FontWeight.bold, 16, kTextColor),
                  ),
                  Text(
                    widget.beneficiaryDetails['phonenumber'] ?? '',
                    style: kTextStlye(FontWeight.normal, 12, kTextColor),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "age".tr(),
                    style: kTextStlye(FontWeight.w500, 15, kTextColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "address_var".tr(),
                    style: kTextStlye(FontWeight.w500, 15, kTextColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                  "CNIC",
                    style: kTextStlye(FontWeight.w500, 15, kTextColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "income".tr(),
                    style: kTextStlye(FontWeight.w500, 15, kTextColor),
                  ),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "amount_var".tr(),
                    style: kTextStlye(FontWeight.w500, 13, kTextColor),
                  ),
                  Text(" ${'rs'.tr()}: ${widget.beneficiaryDetails['requestedAmount']}",
                      style: kTextStlye(FontWeight.w500, 14, Colors.blue)),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    widget.beneficiaryDetails['beneficiaryAge'].toString(),
                    style: kTextStlye(FontWeight.normal, 15, kTextColor),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    SelectLanguage.isEng ? widget.beneficiaryDetails['address']:translatedData['address'],
                    style: kTextStlye(FontWeight.normal, 15, kTextColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    widget.beneficiaryDetails['guardianCNIC'] ?? '',
                    style: kTextStlye(FontWeight.normal, 15, kTextColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    " ${'rs'.tr()}: ${widget.beneficiaryDetails['monthlyIncome']}",
                    style: kTextStlye(FontWeight.normal, 15, kTextColor),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          TextButton(
            child: Text(
              'ver_ben'.tr(),
              style: kTextStlye(
                FontWeight.w600,
                14,
                kTextColor,
              ),
            ),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DonateForBeneficiary(
                  type: widget.type,
                  beneficiaryDetails: widget.beneficiaryDetails,
                  index:widget.index,
                  snapshot: widget.snapshot,
                  //donorPhonenumber: donorPhonenumber,
                ),
              ));
            },
          )
        ],
      ),
    );
  }
}
