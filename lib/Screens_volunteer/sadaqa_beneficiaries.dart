// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, camel_case_types
//
// import 'package:donor_app/constants.dart';
// import 'package:donor_app/models/individual_beneficiary.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
//
// import '../controllers/individual_beneficiary.dart';
// import '../widgets/card_style_widget.dart';
//
// class SadaqaBeneficiaries extends StatefulWidget {
//   static const id = 'sadaqa_beneficiaries';
//
//   @override
//   State<SadaqaBeneficiaries> createState() => _SadaqaBeneficiariesState();
// }
//
// class _SadaqaBeneficiariesState extends State<SadaqaBeneficiaries> {
//   final Future<List<IndividualBeneficiary>> displayedBeneficiaries =
//       getBeneficiaries();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: kAppBar("sadaqa_var".tr()),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: FutureBuilder(
//               future: displayedBeneficiaries,
//               builder: (context,
//                   AsyncSnapshot<List<IndividualBeneficiary>> snapshot) {
//                 if (snapshot.hasData) {
//                   return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (BuildContext context, int index) {
//                       return verifyBeneficiaryCard(
//                         guardianName: snapshot.data![index].guardianName,
//                         guardianCnic: snapshot.data![index].guardianCnic,
//                         address: snapshot.data![index].address,
//                         beneficiaryAge: snapshot.data![index].beneficiaryAge,
//                         isSoleProvider: snapshot.data![index].isSoleProvider,
//                         // dependentNumber: snapshot.data![index].dependentNumber,
//                         // disabilityDesc: snapshot.data![index].disabilityDesc,
//                         // dependentRelation:
//                         // snapshot.data![index].dependentRelation,
//                         // dependentName: snapshot.data![index].dependentName,
//                         // dependentAge: snapshot.data![index].dependentAge,
//                         noOfDependents: snapshot.data![index].noOfDependents,
//                         // hasDisability: snapshot.data![index].hasDisability,
//                         // hasHealthConditions:
//                         //     snapshot.data![index].hasHealthConditions,
//                         // healthConditionDesc:
//                         //     snapshot.data![index].healthConditionDesc,
//                         // liveTogether: snapshot.data![index].liveTogether,
//                         phonenumber: snapshot.data![index].phonenumber,
//                         // requestedAmount: snapshot.data![index].requestedAmount,
//                         monthlyIncome: snapshot.data![index].monthlyIncome,
//                       );
//                       // CampaignCard(
//                       //   id: snapshot.data![index].id,
//                       //   img: snapshot.data![index].img,
//                       //   campaignHeading: SelectLanguage.isEng
//                       //       ? snapshot.data![index].campaignHeading
//                       //       : snapshot.data![index].trCampaignHeading,
//                       //   campaignDescription: SelectLanguage.isEng
//                       //       ? snapshot.data![index].campaignDescription
//                       //       : snapshot.data![index].trCampaignDescription,
//                       //   raisedMoney: snapshot.data![index].raisedMoney,
//                       //   requiredMoney: snapshot.data![index].raisedMoney,
//                       // );
//                     },
//                   );
//                 } else {
//                   return const Center(
//                     child: CircularProgressIndicator(),
//                   );
//                 }
//               },
//               // child: Column(
//               //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               //   children: [
//               //     verifyBeneficiaryCard(
//               //         name: "Muhammad Ali",
//               //         number: "0300-1234566",
//               //         amountRequired: "80,000",
//               //         age: "30",
//               //         city: "Islamabad",
//               //         area: "Korang Town",
//               //         cnic: "61101-9898980-0",
//               //         income: "20,000"),
//               //     verifyBeneficiaryCard(
//               //         name: "Muhammad Ali",
//               //         number: "0300-1234566",
//               //         amountRequired: "80,000",
//               //         age: "30",
//               //         city: "Islamabad",
//               //         area: "Korang Town",
//               //         cnic: "61101-9898980-0",
//               //         income: "20,000"),
//               //   ],
//               // ),
//             ),
//           ),
//         ));
//   }
// }
//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/constants.dart';
import 'package:donor_app/Screens_volunteer/donate_for_beneficiary.dart';
import 'package:donor_app/Screens_volunteer/verify_beneficiary_card.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class SadaqaBeneficiaries extends StatelessWidget {
  static const id = "sadaqa_beneficiaries";

  //String donorPhonenumber;
  //SadaqaBeneficiaries({required this.donorPhonenumber}) : super();
  @override
  Widget build(BuildContext context) {
    var amountRequired = FirebaseFirestore.instance.collection('sadqah').doc();

    return Scaffold(
      appBar: kAppBar('sadqah_var'.tr()),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('sadqah').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasData) {
            final beneficiaries = snapshot.data!.docs;

            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListView.builder(
                itemCount: beneficiaries.length,
                itemBuilder: (context, index) {
                  final beneficiary =
                      beneficiaries[index].data() as Map<String, dynamic>;

                  return InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => DonateForBeneficiary(
                            type: 'sadqah',
                            beneficiaryDetails: beneficiary,
                            index: index,
                            snapshot:snapshot,
                            //donorPhonenumber: donorPhonenumber,
                            // guardianName: beneficiary['guardianName'],
                            // phonenumber: beneficiary['phonenumber'],
                            // requestedAmount: beneficiary['requestedAmount'],
                            // beneficiaryAge: beneficiary['beneficiaryAge'],
                            // address: beneficiary['address'],
                            // guardianCnic: beneficiary['guardianCNIC'],
                            // monthlyIncome: beneficiary['monthlyIncome'],
                            // hasHealthConditions:
                            //     beneficiary['hasHealthConditions'],
                            // isSoleProvider: beneficiary['isSoleProvider'],
                            // dependentAge: beneficiary['dependentAge'],
                            // dependentName: beneficiary['dependentName'],
                            // dependentRelation:
                            //     beneficiary['dependentRelation'],
                            // healthConditionDesc:
                            //     beneficiary['healthConditionDesc'],
                            // disabilityDesc: beneficiary['disabilityDesc'],
                            // hasDisability: beneficiary['hasDisability'],
                            // liveTogether: beneficiary['liveTogether'],
                            // dependentNumber: beneficiary['dependentNumber'],
                            // noOfDependents: beneficiary['noOfDependents']
                          ),
                        ));
                      },
                      child: VerifyBeneficiaryCard(
                        type: 'sadqah',
                        beneficiaryDetails: beneficiary,
                        index: index,
                        snapshot:snapshot,
                        //donorPhonenumber: donorPhonenumber,
                      ));
                },
              ),
            );
          } else {
            return const Center(
              child: Text('No data available'),
            );
          }
        },
      ),
    );
  }
}
