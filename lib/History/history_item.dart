// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class HistoryItem extends StatefulWidget {
  final String historyName;
  final String historyImage;
  HistoryItem({required this.historyImage, required this.historyName});
  @override
  State<HistoryItem> createState() => _HistoryItemState();
}

class _HistoryItemState extends State<HistoryItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100,
          child: Center(
            child: Image.asset(
              widget.historyImage,
              height: 70,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Text(
                      widget.historyName,
                      style: kTextStlye(FontWeight.w600, 18, kTextColor),
                    ),
                  ],
                ),
                Container(
                  height: 35,
                  child: Row(
                    children: [
                      Expanded(
                          child: Text(
                        "benefit_received".tr(),
                        style: kTextStlye(FontWeight.normal, 15, kTextColor),
                      ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Center(
            child: Text(
          "history_date".tr(),
          style: kTextStlye(FontWeight.normal, 14, kTextColor),
        )),
      ],
    );
  }
}
