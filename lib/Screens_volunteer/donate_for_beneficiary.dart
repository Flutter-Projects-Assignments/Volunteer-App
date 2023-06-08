//import 'package:donor_app/screens/donate_money/choose_donation_amount.dart';
//import 'package:donor_app/screens/donate_money/select_payment_method.dart';
//import 'package:donor_app/screens/volunteer/find_volunteer.dart';
//import 'package:donor_app/widgets/text_field_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:donor_app/constants.dart';
//import '../../models/campaign.dart';
import 'package:donor_app/widgets/bottom_button_card.dart';
import 'package:translator/translator.dart';
import 'package:donor_app/Screens_volunteer/select_language.dart';
//import '../../widgets/donation_payment_template.dart';
//import 'package:donor_app/dummy_data.dart';
final _firestore = FirebaseFirestore.instance;

class DonateForBeneficiary extends StatefulWidget {
  static const id = 'donate_for_beneficiary';

  dynamic beneficiaryDetails;
  //String donorPhonenumber;
  String type;
  int index;
  AsyncSnapshot snapshot;

  DonateForBeneficiary({
    Key? key,
    required this.type,
    required this.beneficiaryDetails,
    required this.snapshot,
    required this.index
  }) : super(key: key);

  @override
  State<DonateForBeneficiary> createState() => _DonateForBeneficiaryState();
}

Future<void> sendData(String type, beneficiaryDetails, int index, AsyncSnapshot snapshot) async {
  try {
    // Map<String, dynamic> data_beneficiary = ({
    //   'requestedAmount': amount,
    //   'guardianName': guardianName,
    //   'phonenumber': phonenumber,
    //   'address': address,
    //   'monthlyIncome': monthlyIncome,
    //   'noOfDependents': noOfDependents,
    //   'dependentName': dependentName,
    //   'dependentAge': dependentAge,
    //   'dependentRelation': dependentRelation
    // });
    if (type == 'zakat') {
      await _firestore.collection('Verified_Zakat').doc().set(beneficiaryDetails);
      removeBeneficiary(index,snapshot);
    }
    else if (type == 'charity') {
      await _firestore.collection('Verified_Charity').doc().set(beneficiaryDetails);
      removeBeneficiary(index,snapshot);
    }
    else if(type == 'sadqah') {
      await _firestore.collection('Verified_Sadaqa').doc().set(beneficiaryDetails);
      removeBeneficiary(index,snapshot);
    }
  } catch (e) {
    print("User not added");
  }
}
Future<String?> removeBeneficiary(index, snapshot) async{
  await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
    await myTransaction.delete(snapshot.data.docs[index].reference);
  });
}

class _DonateForBeneficiaryState extends State<DonateForBeneficiary> {
  late int _selectedRadio = -1;
  dynamic translatedData = {
    "name": "",
    "address": "",
    "depName": "",
    "relation": "",
    "illness": "",
    "disability": ""
  };

  Future<void> translateData() async {
    final translator = GoogleTranslator();

    final name = await translator.translate(
        widget.beneficiaryDetails['guardianName'],
        from: 'en',
        to: 'ur');
    final address = await translator
        .translate(widget.beneficiaryDetails['address'], from: 'en', to: 'ur');
    final depName = await translator.translate(
        widget.beneficiaryDetails['dependentName'],
        from: 'en',
        to: 'ur');
    final relation = await translator.translate(
        widget.beneficiaryDetails['dependentRelation'],
        from: 'en',
        to: 'ur');
    final illness = await translator.translate("yes", from: 'en', to: 'ur');
    final disability = await translator.translate("no", from: 'en', to: 'ur');

    setState(() {
      translatedData = {
        "name": name.text,
        "address": address.text,
        "depName": depName.text,
        "relation": relation.text,
        "illness": illness.text,
        "disability": disability.text,
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
    return Scaffold(
      appBar: kAppBar("ben_details".tr()),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: SafeArea(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        SelectLanguage.isEng ? widget.beneficiaryDetails['guardianName']:translatedData['name'],
                        style: kTextStlye(FontWeight.bold, 22, kTextColor),
                      ),
                      Text(
                        widget.beneficiaryDetails['phonenumber'],
                        style: kTextStlye(FontWeight.normal, 16, kPrimaryColor),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        "age".tr(),
                        style: kTextStlye(FontWeight.w500, 16, kTextColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "address_var".tr(),
                        style: kTextStlye(FontWeight.w500, 16, kTextColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "income".tr(),
                        style: kTextStlye(FontWeight.w500, 16, kTextColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "dependent".tr(),
                        style: kTextStlye(FontWeight.w500, 16, kTextColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "dep_name".tr(),
                        style: kTextStlye(FontWeight.w500, 16, kTextColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "dependent_age".tr(),
                        style: kTextStlye(FontWeight.w500, 16, kTextColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "relation".tr(),
                        style: kTextStlye(FontWeight.w500, 16, kTextColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "illness".tr(),
                        style: kTextStlye(FontWeight.w500, 16, kTextColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        "disability".tr(),
                        style: kTextStlye(FontWeight.w500, 16, kTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 7,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "amount_var".tr(),
                        style: kTextStlye(FontWeight.w500, 14, kTextColor),
                      ),
                      Text("${'rs'.tr()} ${widget.beneficiaryDetails['requestedAmount']}",
                          style: kTextStlye(FontWeight.w500, 20, Colors.blue)),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        widget.beneficiaryDetails['beneficiaryAge'].toString(),
                        style: kTextStlye(FontWeight.normal, 16, kTextColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        SelectLanguage.isEng ? widget.beneficiaryDetails['address']:translatedData['address'],
                        style: kTextStlye(FontWeight.normal, 16, kTextColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        " ${'rs'.tr()}: ${widget.beneficiaryDetails['monthlyIncome']}",
                        style: kTextStlye(FontWeight.normal, 16, kTextColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.beneficiaryDetails['noOfDependents'].toString(),
                        style: kTextStlye(FontWeight.w500, 16, kTextColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        SelectLanguage.isEng ? widget.beneficiaryDetails['dependentName']: translatedData['depName'],
                        style: kTextStlye(FontWeight.w500, 16, kTextColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        widget.beneficiaryDetails['dependentAge'],
                        style: kTextStlye(FontWeight.w500, 16, kTextColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        SelectLanguage.isEng ? widget.beneficiaryDetails['dependentRelation']:translatedData['relation'],
                        style: kTextStlye(FontWeight.w500, 16, kTextColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        SelectLanguage.isEng ? widget.beneficiaryDetails['hasHealthCondtitions'].toString():translatedData['illness'].toString(),
                        style: kTextStlye(FontWeight.w500, 16, kTextColor),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        SelectLanguage.isEng ? widget.beneficiaryDetails['hasDisability'].toString():translatedData['disability'].toString(),
                        style: kTextStlye(FontWeight.w500, 16, kTextColor),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {

    // sendNotification(int.parse(_amountController.text));
                    print(widget.beneficiaryDetails);
                    //
                    sendData(widget.type,widget.beneficiaryDetails, widget.index, widget.snapshot);
                    print("phonenumber in donate for beneficiary ${widget.beneficiaryDetails['phonenumber']}");
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Transform.scale(
                        scale: 2.0,
                        child: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 50,
                  ),
                  InkWell(
                    onTap: () {
                      removeBeneficiary(widget.index,widget.snapshot);
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Transform.scale(
                        scale: 2.0,
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
