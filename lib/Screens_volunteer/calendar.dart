import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/colors.dart';
import 'tasks.dart';
import 'package:table_calendar/table_calendar.dart';

class TasksUI extends StatelessWidget {
  final List<DateTime> upcomingTaskDates = [
    DateTime(2023, 4, 10),
    DateTime(2023, 4, 12),
    DateTime(2023, 4, 15),
  ];

  //List<DateTime> upcomingTaskDates = ['2023-04-10', '2023-04-15', '2023-04-20'];
  //List<DateTime> upcomingTaskDates = tasks.map((task) => task.dueDate).toList();
  final List<int> taskProgress;
  TasksUI({required this.taskProgress});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                iconTheme: IconThemeData(color: ColorConstants.myBlack),
                centerTitle: true,
                title: Text(
                  'your_tasks'.tr(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                backgroundColor: ColorConstants.main_Background,
                actions: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {},
                        child:
                            SvgPicture.asset('images/icons/notifications.svg'),
                      ))
                ]),
            body: Container(
                color: ColorConstants.main_Background,
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListView(shrinkWrap: true, children: [
                      Text(
                        "statistics".tr(),
                        style: TextStyle(
                          color: ColorConstants.myBlack,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Color(0xFFffffff),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xffCECECEFF),
                              blurRadius: 5.0, // soften the shadow
                              spreadRadius: 0.0, //extend the shadow
                              offset: Offset(
                                3.0, // Move to right 5  horizontally
                                3.0, // Move to bottom 5 Vertically
                              ),
                            )
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // _buildTaskCountWidget(),
                            // SizedBox(width: 4),
                            Expanded(
                              child: _buildTaskBars(),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 7),
                      Text(
                        "today".tr(),
                        style: TextStyle(
                          color: ColorConstants.myBlack,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                            color: Color(0xFFffffff),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xffCECECEFF),
                                blurRadius: 5.0, // soften the shadow
                                spreadRadius: 0.0, //extend the shadow
                                offset: Offset(
                                  3.0, // Move to right 5  horizontally
                                  3.0, // Move to bottom 5 Vertically
                                ),
                              )
                            ],
                          ),
                          child: Column(children: [
                            SizedBox(height: 1),
                            CustomCalendar(upcomingTasks: upcomingTaskDates),
                          ])),

                    ])))));
  }

  Widget _buildTaskCountWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'this_week'.tr(),
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        SizedBox(height: 12),
        Text(
          'no_tasks'.tr(),
          style: TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildTaskBars() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        for (int i = 0; i < taskProgress.length; i++)
          Container(
            margin: EdgeInsets.only(bottom: 8),
            child: Row(
              children: <Widget>[
                SizedBox(width: 10),
                Text(
                  _getWeekdayInitial(i + 1),
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: 5),
                _buildTaskBar(i, taskProgress[i]),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildTaskBar(int index, int progress) {
    return Container(
      width: 15,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.5),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width: 20,
            height: (progress / 100) * 60,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4),
                topRight: Radius.circular(4),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getWeekdayInitial(int weekday) {
    switch (weekday) {
      case 1:
        return 'M';
      case 2:
        return 'T';
      case 3:
        return 'W';
      case 4:
        return 'T';
      case 5:
        return 'F';
      case 6:
        return 'S';
      case 7:
        return 'S';
      default:
        return '';
    }
  }
}

class CustomCalendar extends StatefulWidget {
  final List<DateTime> upcomingTasks;

  CustomCalendar({required this.upcomingTasks});

  @override
  _CustomCalendarState createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  Map<DateTime, List> _events = {
    DateTime.now(): ['Event 1', 'Event 2', 'Event 3'],
    DateTime.now().add(Duration(days: 1)): ['Event 4', 'Event 5'],
    DateTime.now().add(Duration(days: 3)): ['Event 6'],
    DateTime.now().add(Duration(days: 7)): ['Event 7', 'Event 8'],
  };

  List<Widget> _buildUpcomingTasks() {
    List<Widget> tasks = [];

    for (int i = 0; i < widget.upcomingTasks.length; i++) {
      tasks.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            widget.upcomingTasks[i].toString(),
            style: TextStyle(
              decoration: TextDecoration.underline,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    return tasks;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        color: Color(0xFFffffff),
        boxShadow: [
          BoxShadow(
            color: Color(0xffCECECEFF),
            blurRadius: 5.0, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
            offset: Offset(
              3.0, // Move to right 5  horizontally
              3.0, // Move to bottom 5 Vertically
            ),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TableCalendar(
            firstDay: DateTime.utc(2021, 01, 01),
            lastDay: DateTime.utc(2031, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            selectedDayPredicate: (day) {
              return isSameDay(day, _selectedDay);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) {
              return _events[day] ?? [];
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: ColorConstants.kPrimaryColor,
              ),
              todayTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              selectedDecoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[300],
              ),
              selectedTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 16),
          // Text(
          //   'upcoming_tasks'.tr(),
          //   style: TextStyle(
          //     fontWeight: FontWeight.bold,
          //     fontSize: 16,
          //   ),
          // ),
          // SizedBox(height: 8),
          // Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: _buildUpcomingTasks(),
          // ),
        ],
      ),
    );
  }
}
