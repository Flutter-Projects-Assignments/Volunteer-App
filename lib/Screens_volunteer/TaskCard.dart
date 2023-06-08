import 'package:donor_app/Screens_volunteer/select_language.dart';
import 'package:donor_app/Screens_volunteer/track_location.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

import '../Constants/Colors.dart';
import '../constants.dart';

class TaskCard extends StatefulWidget {
  String bname;
  String dnumber;
  String bnumber;
  String daddress;
  String baddress;
  String amount;

  TaskCard({
    Key? key,
    required this.bname,
    required this.bnumber,
    required this.baddress,
    required this.dnumber,
    required this.daddress,
    required this.amount,
  }) : super(key: key);

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {

  dynamic translatedData = {
    "bname": "",
    "baddress": "",
    "daddress": "",
  };

  Future<void> translateData() async {
    final translator = GoogleTranslator();

    final bname = await translator.translate(
        widget.bname,
        from: 'en',
        to: 'ur');
    final baddress = await translator
        .translate(widget.baddress, from: 'en', to: 'ur');
    final daddress = await translator.translate(
        widget.daddress,
        from: 'en',
        to: 'ur');

    setState(() {
      translatedData = {
        "bname": bname.text,
        "baddress": baddress.text,
        "daddress": daddress.text,
      };
    });
  }

  @override
  void initState() {
    if(SelectLanguage.isEng == false){
      translateData();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=> TrackLocation()));
      },
      child: Container(
        // height: 200,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Colors.white),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("wednesday".tr(),
                    style: kTextStlye(
                      FontWeight.bold, 15,
                      ColorConstants.myBlack, )),
                Text("25",
                    style: TextStyle(
                        color: ColorConstants.myBlack,
                        fontSize: 30,
                        fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(width: 15),
            Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "donor_details".tr(),
                      style: kTextStlye(FontWeight.w600, 18, kTextColor),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text("phone_num_var".tr() + ":  ",
                            style: kTextStlye(FontWeight.w500, 15, kPrimaryColor)),
                        Text(widget.dnumber,
                            style: kTextStlye(FontWeight.normal, 15, kTextColor)),
                      ],
                    ),SizedBox(height: 5,),
                    Row(
                      children: [
                        Text("address_var".tr() + ":  ",
                            style: kTextStlye(FontWeight.w500, 15, kPrimaryColor)),
                        Text(SelectLanguage.isEng ? widget.daddress:translatedData['daddress'],
                            style: kTextStlye(FontWeight.normal, 15, kTextColor)),
                      ],
                    ),SizedBox(height: 5,),
                    Row(
                      children: [
                        Text("amount_var".tr() + ":  ",
                            style: kTextStlye(FontWeight.w500, 15, kPrimaryColor)),
                        Text("Rs " + widget.amount,
                            style: kTextStlye(FontWeight.normal, 15, kTextColor)),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "beneficiary_detail".tr(),
                      style: kTextStlye(FontWeight.w600, 18, kTextColor),
                    ),SizedBox(height: 5,),
                    Row(
                      children: [
                        Text("name_var".tr(),
                            style: kTextStlye(FontWeight.w500, 15, kPrimaryColor)),
                        Text(SelectLanguage.isEng ? widget.bname:translatedData['bname'],
                            style:kTextStlye(FontWeight.normal, 15, kTextColor)),
                      ],
                    ),
                    Row(
                      children: [
                        Text("address_var".tr() + ":  ",
                            style: kTextStlye(FontWeight.w500, 15, kPrimaryColor)),
                        Text(SelectLanguage.isEng ? widget.baddress:translatedData['baddress'],
                            style: kTextStlye(FontWeight.normal, 15, kTextColor)),
                      ],
                    ),SizedBox(height: 5,),
                    Row(
                      children: [
                        Text("phone_num_var".tr() + ":  ",
                            style: kTextStlye(FontWeight.w500, 15, kPrimaryColor)),
                        Text(widget.bnumber,
                            style: kTextStlye(FontWeight.normal, 15, kTextColor)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}