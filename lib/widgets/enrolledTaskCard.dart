// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../Constants/colors.dart';

class enrolledTaskCard extends StatelessWidget {
  String title = "";
  String location = "";
  String date = "";
  String imagePath = "";

  enrolledTaskCard(
      {required this.title,
      required this.location,
      required this.date,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      decoration: BoxDecoration(
          color: ColorConstants.primary_color,
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: Image.asset(imagePath).image,
            fit: BoxFit.cover,
          )),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title,
                      style: TextStyle(
                          color: ColorConstants.myWhite,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                  Text("Details",
                      style: TextStyle(
                          color: ColorConstants.myWhite,
                          fontSize: 12,
                          fontWeight: FontWeight.w400)),
                ],
              ),
              Container(
                  child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: ColorConstants.myWhite,
                        size: 14,
                      ),
                      SizedBox(width: 5),
                      Text(date,
                          style: TextStyle(
                              color: ColorConstants.myWhite,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        color: ColorConstants.myWhite,
                        size: 14,
                      ),
                      SizedBox(width: 5),
                      Text(date,
                          style: TextStyle(
                              color: ColorConstants.myWhite,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                    ],
                  ),
                ],
              )),
            ]),
      ),
    );
  }
}
