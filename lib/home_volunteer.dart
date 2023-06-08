import 'package:flutter/material.dart';

import 'Constants/colors.dart';
import 'Screens_volunteer/VolunteerDashboard.dart';
import 'History/History.dart';
import 'Profile/ProfileVolunteer.dart';
import 'Screens_volunteer/TasksVolunteer.dart';
import 'Screens_volunteer/login_signup/login.dart';
import 'Screens_volunteer/tasks.dart';
import 'constants.dart';

class Home extends StatefulWidget {
  final dynamic phonenumber;
  Home({required this.phonenumber}): super();

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: [
          VolunteerDashboard(phonenumber: widget.phonenumber,),
          VolunteerTask(phonenumber: widget.phonenumber),
          History(phonenumber: widget.phonenumber),
          Profile(phonenumber: widget.phonenumber),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: kLightGray),
            activeIcon: Icon(Icons.home, color: ColorConstants.primary_color),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: kLightGray),
            activeIcon:
                Icon(Icons.calendar_today, color: ColorConstants.primary_color),
            label: 'Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history, color:kLightGray),
            activeIcon:
                Icon(Icons.history, color: ColorConstants.primary_color),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: kLightGray),
            activeIcon: Icon(Icons.person, color: ColorConstants.primary_color),
            label: 'Profile',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (int index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
