import 'package:flutter/material.dart';

import '../constants.dart';

class NewCard extends StatelessWidget {
  Widget widget;
  double cardHeight;

  NewCard({required this.cardHeight, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shadowColor: const Color(0x55002636),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: SizedBox(
        height: cardHeight,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
          child: widget,
        ),
      ),
    );
  }
}

class ColumnCard extends StatelessWidget {
  Widget widget1;
  Widget widget2;
  double cardHeight;

  ColumnCard(
      {required this.widget1, required this.widget2, required this.cardHeight});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Card(
            elevation: 5,
            shadowColor: const Color(0x55002636),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: SizedBox(
              height: cardHeight,
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: widget1,
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            elevation: 5,
            shadowColor: const Color(0x55002636),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: SizedBox(
              height: cardHeight,
              child: Container(
                padding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                child: widget2,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CardHeading extends StatelessWidget {
  String heading;

  CardHeading({
    required this.heading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 3),
      child: Text(
        heading,
        textAlign: TextAlign.start,
        style: kTextStlye(
          FontWeight.normal,
          14.0,
          kSectionHeadingColor,
        ),
      ),
    );
  }
}

class Donations_card extends StatelessWidget {
  String type;
  String title;
  String description;
  String things;

  Donations_card({
    Key? key,
    required this.type,
    required this.title,
    required this.description,
    required this.things,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          type,
          style: TextStyle(color: kSectionHeadingColor),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          title.toUpperCase(),
          style: TextStyle(
              color: kTextColor,
              fontSize: kMainHeadingSize,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          description,
          style: TextStyle(color: kSectionHeadingColor, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: Container(
            child: Text(
              things,
              style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: kMainHeadingSize,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }
}

class volunteers_card extends StatelessWidget {
  String day;
  double progress;
  int progressValue;
  int totalValue;
  String name;
  String description;
  String time;

  volunteers_card(
      {required this.day,
        required this.progress,
        required this.progressValue,
        required this.totalValue,
        required this.name,
        required this.description,
        required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          day,
          style: TextStyle(color: kSectionHeadingColor),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "PROGRESS".toUpperCase(),
          style: TextStyle(color: kTextColor, fontSize: kMainHeadingSize),
        ),
        SizedBox(
          height: 10,
        ),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.grey[200],
          valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: Container(
            child: Text(
              "$progressValue/$totalValue RS".toUpperCase(),
              style: TextStyle(color: kSectionHeadingColor, fontSize: 12),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          name,
          style: TextStyle(color: kPrimaryColor, fontSize: 25.0),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          description,
          style: TextStyle(color: kSectionHeadingColor, fontSize: 15),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: Container(
            child: Text(
              time,
              style: TextStyle(
                  color: kTextColor,
                  fontSize: kMainHeadingSize,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }
}