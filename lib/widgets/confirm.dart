// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../Constants/colors.dart';
import '../Navigation/navigation_bar.dart';
import '../home_volunteer.dart';


class Confirm extends StatelessWidget {
  static const id = 'dashboard';
  String phonenumber;
  Confirm({required this.phonenumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: ColorConstants.myBlack),
          centerTitle: true,
          title: Text(
            'confirmation'.tr(),
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: ColorConstants.main_Background,
        ),
        body: Padding(
          padding: const EdgeInsets.all(50),
          child: Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 150,
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "confirm".tr(),
                  style: TextStyle(fontSize: 18),
                ),
                 SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => Home(phonenumber: phonenumber,)),
                      );
                    },
                    child: Text(
                      "dashboard".tr(),
                      style: TextStyle(fontSize: 15),
                    ))
              ],
            ),
          ),
        ));
  }
}
