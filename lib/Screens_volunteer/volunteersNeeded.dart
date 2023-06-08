// ignore_for_file: prefer_const_constructors, use_full_hex_values_for_flutter_colors, prefer_const_literals_to_create_immutables, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/Screens_volunteer/select_language.dart';
import 'package:donor_app/Screens_volunteer/tasks.dart';
import 'package:donor_app/Screens_volunteer/track_location.dart';
import 'package:donor_app/constants.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:translator/translator.dart';
import '../Constants/Colors.dart';
import '../Constants/colors.dart' as color;

class VolunteersNeeded extends StatelessWidget {
  String phonenumber;
  VolunteersNeeded({required this.phonenumber}):super();

  SnackBar taskAdded = SnackBar(
    content: Text('Your Task has been Added',style: kTextStlye(FontWeight.normal, 15, kLightPrimaryColor),),
    duration: Duration(seconds: 3),
    backgroundColor: kSecondaryColor2.withOpacity(0.9),
  );

  Future<String?> setEnrolledTasks(Map<String,dynamic> task) async{
    try {
      task.addAll({'phonenumber': phonenumber});
      CollectionReference users =
      FirebaseFirestore.instance.collection('EnrolledTasks');
      // Call the user's CollectionReference to add a new user
      await users.add(task);
      print('success');
      return 'success';
    } catch (e) {
      return 'Error adding user';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(color: ColorConstants.myBlack),
          centerTitle: true,
          title: Text(
            'home_dashboard'.tr(),
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
                  child: SvgPicture.asset('images/icons/notifications.svg'),
                ))
          ]),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('VolunteerTask')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              final AllTask = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: AllTask.length,
                    itemBuilder: (context, index) {
                      final task =
                      AllTask[index].data() as Map<String, dynamic>;

                      return Column(
                        children: [
                          TaskCard(
                            bname: "${task['bname'] ?? ''}",
                            bnumber: "${task['bnumber'] ?? ''}",
                            baddress: "${task['baddress'] ?? ''}",
                            dnumber: "${task['dnumber'] ?? ''}",
                            daddress: "${task['daddress'] ?? ''}",
                            amount: "${task['amount'] ?? ''}",
                            onPressed: ()async{
                              await setEnrolledTasks(task);
                              if(context.mounted){
    ScaffoldMessenger.of(context).showSnackBar(taskAdded);

    }}
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=> VolunteerTask()));}
                          ),
                          SizedBox(
                            height: 10,
                          )
                        ],
                      );
                    }),
              );
            } else {
              return Center(
                child: Text('No data available'),
              );
            }
          }),
    );
  }
}


class TaskCard extends StatefulWidget {
  String bname;
  String dnumber;
  String bnumber;
  String daddress;
  String baddress;
  String amount;
  Function() ? onPressed;

  TaskCard({
    Key? key,
    required this.bname,
    required this.bnumber,
    required this.baddress,
    required this.dnumber,
    required this.daddress,
    required this.amount,
    required this.onPressed
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
                        Text(SelectLanguage.isEng ? widget.bname: translatedData['bname'],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(width: 40,),
                        IconButton(onPressed: widget.onPressed,
                          icon: Icon(Icons.check_circle_rounded,color: Colors.green,size: 50,), ),
                        SizedBox(width: 20,),
                        IconButton(onPressed: (){}, icon: Icon(Icons.cancel,color: ColorConstants.kSecondaryColor1,size: 50,), ),

                      ],)
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

