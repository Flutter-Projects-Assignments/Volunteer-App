// ignore_for_file: must_be_immutable

import 'package:donor_app/Screens_volunteer/tasks.dart';
import 'package:donor_app/Screens_volunteer/volunteersNeeded.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../Constants/colors.dart';
import '../widgets/needed.dart';
import 'calendar.dart';

class Tasks extends StatelessWidget {
  List<int> taskProgress = [80, 60, 20, 100, 50, 0, 90];

  String phonenumber;
  Tasks({required this.phonenumber}):super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'tasks'.tr(),style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
          ),backgroundColor: ColorConstants.main_Background,centerTitle: true,),
        drawer: Drawer(

        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "no_task".tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.push(
                //         context,
                //         MaterialPageRoute(
                //             builder: (context) =>
                //                 VolunteersNeeded(phonenumber: phonenumber,)));
                //   },
                //   child: Text('explore_volunteering'.tr()),
                //   style: TextButton.styleFrom(
                //     foregroundColor: Colors.white, backgroundColor: Colors.blue, disabledForegroundColor: Colors.grey.withOpacity(0.38),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
