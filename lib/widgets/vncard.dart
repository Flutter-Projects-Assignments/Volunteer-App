// ignore_for_file: must_be_immutable

import 'package:donor_app/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../Constants/colors.dart';

class VNCard extends StatelessWidget {
  String iconPath = "";
  String title = "";
  String location = "";
  int volunteersNeeded = 0;
  double width = 0.0;

  VNCard(
      {required this.iconPath,
      required this.title,
      required this.location,
      required this.volunteersNeeded,
      required this.width});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: kPrimaryColor.withOpacity(0.5),
            // boxShadow: [
            //   BoxShadow(
            //     color: Color(0xffCECECEFF),
            //     blurRadius: 4.0, // soften the shadow
            //     spreadRadius: 0.0, //extend the shadow
            //     offset: Offset(
            //       2.0, // Move to right 5  horizontally
            //       1.0, // Move to bottom 5 Vertically
            //     ),
            //   )
            // ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                width: width,
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  Text(location,
                      style: TextStyle(
                          color: kTextColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w400)),
                ],
              )
            ],
          ),
        ),
        Positioned(
          bottom: 8,
          right: 15,
          child: Row(
            children: [
              Text("volunteers_needed".tr()),
              Text(
                volunteersNeeded.toString(),
                style: TextStyle(color: ColorConstants.myRed),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
