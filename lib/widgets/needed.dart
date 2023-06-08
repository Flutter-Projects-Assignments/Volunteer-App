// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// import '../widgets/colors.dart';
// import '../widgets/vncard.dart';
//
// class VolunteersNeeded extends StatelessWidget {
//   VolunteersNeeded({Key? key}) : super(key: key);
//
//   final List<VNCard> VNlist = [
//     VNCard(
//       title: "med_delivery".tr(),
//       iconPath: "images/charity.png",
//       location: "islamabad".tr(),
//       volunteersNeeded: 5,
//       width: 60,
//     ),
//     VNCard(
//       title: "sadqa_delivery".tr(),
//       iconPath: "images/donation_box.png",
//       location: "islamabad".tr(),
//       volunteersNeeded: 5,
//       width: 60,
//     ),
//     VNCard(
//       title: "donation_collection".tr(),
//       iconPath: "images/sadqah.png",
//       location: "islamabad".tr(),
//       volunteersNeeded: 5,
//       width: 60,
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//             iconTheme: IconThemeData(color: ColorConstants.myBlack),
//             centerTitle: true,
//             title: Text(
//               'volunteer_dashboard'.tr(),
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             backgroundColor: ColorConstants.main_Background,
//             actions: <Widget>[
//               Padding(
//                   padding: EdgeInsets.only(right: 20.0),
//                   child: GestureDetector(
//                     onTap: () {},
//                     child: SvgPicture.asset('images/icons/notifications.svg'),
//                   ))
//             ]),
//         body: ListView.builder(
//           itemCount: VNlist.length,
//           itemBuilder: (BuildContext context, int index) {
//             return Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: VNlist[index],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
