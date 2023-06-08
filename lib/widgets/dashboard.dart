// // ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:donor_app/Beneficiary/register_beneficiary.dart';
// import 'package:donor_app/Screens_volunteer/volunteersNeeded.dart';
// import '../../../Beneficiary/verify_beneficiary.dart';
// import '../../../Constants/Colors.dart';
// import '../../../Navigation/navigation_bar.dart';
// import '../../../Profile/edit_profile.dart';
// import '../../../widgets/enrolledTaskCard.dart';
// import '../../../widgets/vncard.dart';
// import 'calendar.dart';
//
// class VolunteerDashboard extends StatelessWidget {
//   const VolunteerDashboard({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//         drawer:
//         Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: [
//               DrawerHeader(
//                 decoration: BoxDecoration(
//                   color: Colors.blue,
//                 ),
//                 child: Center(child: Text('Volunteer'.tr(), style: TextStyle(fontSize: 20),)),
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.home,
//                 ),
//                 title: const Text('Dashboard', style: TextStyle(fontSize: 16),),
//                 onTap: () {
//                   Navigator.push(
//                       context, MaterialPageRoute(builder: (context) => NavBar()));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.account_box_rounded,
//                 ),
//                 title: const Text('Tasks', style: TextStyle(fontSize: 16),),
//                 onTap: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => TasksUI(taskProgress: [])));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.app_registration,
//                 ),
//                 title: const Text('Register Beneficiary', style: TextStyle(fontSize: 16),),
//                 onTap: () {
//                   Navigator.push(
//                       context, MaterialPageRoute(builder: (context) => RegisterBeneficiary()));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.verified,
//                 ),
//                 title: const Text('Verify Beneficiary', style: TextStyle(fontSize: 16),),
//                 onTap: () {
//                   Navigator.push(
//                       context, MaterialPageRoute(builder: (context) => VerifyBeneficiary()));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.edit,
//                 ),
//                 title: const Text('Edit Profile', style: TextStyle(fontSize: 16),),
//                 onTap: () {
//                   Navigator.push(
//                       context, MaterialPageRoute(builder: (context) => EditProfile()));
//                 },
//               ),
//               ListTile(
//                 leading: Icon(
//                   Icons.logout,
//                 ),
//                 title: const Text('Log Out', style: TextStyle(fontSize: 16),),
//                 onTap: () {
//                   Navigator.push(
//                       context, MaterialPageRoute(builder: (context) => NavBar()));
//                 },
//               ),
//             ],
//           ),
//
//         ),
//         body: StreamBuilder<QuerySnapshot>(
//         stream: FirebaseFirestore.instance
//             .collection('VolunteerTask')
//         .limit(1)
//         .snapshots(),
//     builder: (context, snapshot) {
//     if (snapshot.connectionState == ConnectionState.waiting) {
//     return Center(
//     child: CircularProgressIndicator(),
//     );
//     } else if (snapshot.hasData) {
//     final AllTask = snapshot.data!.docs;
//     return SafeArea(
//     child: Container(
//     color: ColorConstants.main_Background,
//     child: Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: ListView(
//     shrinkWrap: true,
//     children: [
//     Text(
//     "upcoming_tasks".tr(),
//     style:
//     TextStyle(color: ColorConstants.lightGray, fontSize: 16),
//     ),
//     const SizedBox(height: 10),
//     Container(
//     width: double.infinity,
//     padding: const EdgeInsets.all(20),
//     decoration: const BoxDecoration(
//     borderRadius: BorderRadius.all(Radius.circular(5)),
//     color: Color(0xFFffffff),
//     boxShadow: [
//     BoxShadow(
//     color: Color(0xffCECECEFF),
//     blurRadius: 5.0, // soften the shadow
//     spreadRadius: 0.0, //extend the shadow
//     offset: Offset(
//     3.0, // Move to right 5  horizontally
//     3.0, // Move to bottom 5 Vertically
//     ),
//     )
//     ],
//     ),
//     child: Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     Column(
//     children: [
//     Text("wednesday".tr(),
//     style: TextStyle(
//     color: ColorConstants.myBlack,
//     fontSize: 14,
//     fontWeight: FontWeight.bold)),
//     Text("25",
//     style: TextStyle(
//     color: ColorConstants.myBlack,
//     fontSize: 30,
//     fontWeight: FontWeight.w500)),
//     ],
//     ),
//     SizedBox(width: MediaQuery.of(context).size.width * 0.1),
//     Expanded(
//     child: Column(
//     children: [
//     Container(
//     width: double.infinity,
//     padding: const EdgeInsets.all(10),
//     decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(5),
//     color: ColorConstants.primary_color,
//     ),
//     child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     Text("med_delivery".tr(),
//     style: TextStyle(
//     color: ColorConstants.myWhite,
//     fontSize: 14,
//     fontWeight: FontWeight.bold)),
//     SizedBox(height: 5),
//     Text("12-2:00 pm",
//     style: TextStyle(
//     color: ColorConstants.myWhite,
//     fontSize: 12,
//     fontWeight: FontWeight.w400)),
//     ],
//     ),
//     ),
//     const SizedBox(height: 10),
//     Container(
//     width: double.infinity,
//     padding: const EdgeInsets.all(10),
//     decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(5),
//     color: ColorConstants.lightGreen,
//     ),
//     child: Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//     Text("donation_collection".tr(),
//     style: TextStyle(
//     color: ColorConstants.myWhite,
//     fontSize: 14,
//     fontWeight: FontWeight.bold)),
//     SizedBox(height: 5),
//     Text("1-6:00 pm",
//     style: TextStyle(
//     color: ColorConstants.myWhite,
//     fontSize: 12,
//     fontWeight: FontWeight.w400)),
//     ],
//     ),
//     ),
//     ],
//     ),
//     ),
//     ],
//     ),
//     ),
//     const SizedBox(height: 5),
//     GestureDetector(
//     onTap: () {
//     //Navigator.push(context,
//     //MaterialPageRoute(
//     //builder: (context) =>
//     //TasksUI(taskProgress: taskProgress)));
//     },
//     child: VNCard(
//     title: "reg_beneficary".tr(),
//     iconPath: "images/zakat.png",
//     location: "islamabad".tr(),
//     volunteersNeeded: 5,
//     width: 40,
//     ),
//     ),
//     const SizedBox(height: 20),
//     Row(
//     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//     children: [
//     Text(
//     "volunteers_needed".tr(),
//     style: TextStyle(
//     color: ColorConstants.lightGray, fontSize: 18),
//     ),
//     TextButton(
//     onPressed: () {
//     Navigator.push(
//     context,
//     MaterialPageRoute(
//     builder: (context) => VolunteersNeeded()));
//     },
//     child: Text(
//     "more".tr(),
//     style: TextStyle(
//     color: ColorConstants.myBlack,
//     fontSize: 14,
//     fontWeight: FontWeight.w500),
//     ),
//     ),
//     ],
//     ),
//     const SizedBox(height: 5),
//     VNCard(
//     title: "med_delivery".tr(),
//     iconPath: "images/charity.png",
//     location: "islamabad".tr(),
//     volunteersNeeded: 5,
//     width: 60,
//     ),
//     const SizedBox(height: 5),
//     VNCard(
//     title: "sadqa_delivery".tr(),
//     iconPath: "images/sadqah.png",
//     location: "islamabad".tr(),
//     volunteersNeeded: 5,
//     width: 60,
//     ),
//     const SizedBox(height: 5),
//     VNCard(
//     title: "donation_collection".tr(),
//     iconPath: "images/donation_box.png",
//     location: "islamabad".tr(),
//     volunteersNeeded: 5,
//     width: 60,
//     ),
//     const SizedBox(height: 30),
//     Text(
//     "enrolled_tasks".tr(),
//     style:
//     TextStyle(color: ColorConstants.lightGray, fontSize: 18),
//     ),
//     const SizedBox(height: 10),
//     enrolledTaskCard(
//     imagePath: "images/flood.jpg",
//     title: "zakaat_collection".tr(),
//     location: "islamabad".tr(),
//     date: "25 ${"may".tr()}, 2023",
//     ),
//     SizedBox(height: 5),
//     enrolledTaskCard(
//     imagePath: "images/calamity.png",
//     title: "collection".tr(),
//     location: "wahcantt".tr(),
//     date: "17 ${"august".tr()}, 2023",
//     ),
//     ],
//     ),
//     ),
//     ),
//     ),
//     );
//     }
//     }
//
//
