// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, camel_case_types
//
// import 'package:flutter/material.dart';
// import '../Constants/colors.dart';
// import '../Screens_volunteer/card_style_widget.dart';
// import 'verify_beneficiary.dart';
//
// class beneficiaryDetails extends StatelessWidget {
//   const beneficiaryDetails({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           iconTheme: IconThemeData(color: ColorConstants.myBlack),
//           centerTitle: true,
//           title: Text(
//             'Beneficiary Verification',
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//           backgroundColor: ColorConstants.main_Background,
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 verifyBeneficiaryCard(
//                     name: "Muhammad Ali",
//                     number: "0300-1234566",
//                     amountRequired: "80,000",
//                     age: "30",
//                     city: "Islamabad",
//                     area: "Korang Town",
//                     cnic: "61101-9898980-0",
//                     income: "20,000"),
//                 verifyBeneficiaryCard(
//                     name: "Muhammad Ali",
//                     number: "0300-1234566",
//                     amountRequired: "80,000",
//                     age: "30",
//                     city: "Islamabad",
//                     area: "Korang Town",
//                     cnic: "61101-9898980-0",
//                     income: "20,000"),
//                 verifyBeneficiaryCard(
//                     name: "Muhammad Ali",
//                     number: "0300-1234566",
//                     amountRequired: "80,000",
//                     age: "30",
//                     city: "Islamabad",
//                     area: "Korang Town",
//                     cnic: "61101-9898980-0",
//                     income: "20,000"),
//               ],
//             ),
//           ),
//         ));
//   }
// }
//
// class verifyBeneficiaryCard extends StatelessWidget {
//   String name;
//   String number;
//   String amountRequired;
//   String type;
//   verifyBeneficiaryCard({
//     Key? key,
//     required this.name,
//     required this.number,
//     required this.amountRequired,
//     required this.age,
//     required this.city,
//     required this.area,
//     required this.cnic,
//     required this.income,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return NewCard(
//       cardHeight: 220,
//       widget: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Row(
//             children: [
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     name,
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                   Text(
//                     number,
//                     style: TextStyle(
//                       fontSize: 12,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Text("Age"),
//                   Text("City"),
//                   Text("Area"),
//                   Text("Cnic"),
//                   Text("Income"),
//                 ],
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Amount Required",
//                     style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
//                   ),
//                   Text("Rs $amountRequired",
//                       style: TextStyle(
//                           fontWeight: FontWeight.w500,
//                           fontSize: 14,
//                           color: Colors.blue)),
//                   SizedBox(
//                     height: 30,
//                   ),
//                   Text(age),
//                   Text(city),
//                   Text(area),
//                   Text(cnic),
//                   Text(" Rs: $income"),
//                 ],
//               ),
//             ],
//           ),
//           GestureDetector(
//             onTap: () {},
//             child: Text(
//               'See Details',
//               style: TextStyle(
//                 decoration: TextDecoration.underline,
//                 decorationStyle: TextDecorationStyle.solid,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
