// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, use_key_in_widget_constructors, must_be_immutable
import 'package:donor_app/widgets/input_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/colors.dart';
import '../widgets/confirm.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = FirebaseFirestore.instance;
class RegisterBeneficiary extends StatefulWidget {
  static const id = 'register_beneficiary';
  // late final dynamic beneficiaryDetails;
  String phonenumber;

  RegisterBeneficiary({required this.phonenumber}):super();

  @override
  State<RegisterBeneficiary> createState() => _RegisterBeneficiaryState();
}

class _RegisterBeneficiaryState extends State<RegisterBeneficiary> {
  bool isChecked1 = false;
  bool isChecked2 = false;
  TextEditingController nameTextController = TextEditingController();
  TextEditingController cnicTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController pwdTextController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  late String name;
  late String cnic;
  late String phoneNumber;
  late String pwd;

  @override
  void initState() {
    super.initState();
  }

  Future<void> sendData(String name, String cnic,String pwd, String phoneNumber) async {
    try {
      Map<String, dynamic> data = ({
        'name': name,
        'cnic': cnic,
        'password': pwd,
        'phonenumber': phoneNumber,
        'receivedAmount': 0,
        'userId': "beneficiary"

      });
      await _firestore.collection('Beneficiaries').doc().set(data);
    } catch (e) {
      print("User not added");
    }
  }
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: ColorConstants.myBlack),
            centerTitle: true,
            title: Text(
              'reg_new'.tr(),
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
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ben_name".tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 500,
                          child: InputTextField(
                            controller: nameTextController,
                            // decoration: InputDecoration(
                            //   border: OutlineInputBorder(
                            //     borderRadius: BorderRadius.circular(10.0),
                            //   ),
                            hintText: 'enter_name'.tr(),
                            keyboardType: TextInputType.text,
                            hideText: false,
                            onChanged: (value) {
                              name = value;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "enter_cnic".tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 500,
                            child: InputTextField(
                              controller: cnicTextController,
                              // decoration: InputDecoration(
                              //   border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(10.0),
                              //   ),
                              hintText: 'xxxxx-xxxxxxx-x',
                              keyboardType: TextInputType.text,
                              hideText: false,
                              onChanged: (value) {
                                cnic = value;
                              },
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "enter_phone".tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 500,
                            child: InputTextField(
                              controller: phoneTextController,
                              // decoration: InputDecoration(
                              //   border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(10.0),
                              //   ),
                              hintText: 'phone_num_var'.tr(),
                              keyboardType: TextInputType.text,
                              hideText: false,
                              onChanged: (value) {
                                phoneNumber = value;
                              },
                            ),
                          ),
                        ]),
                    SizedBox(
                      height: 20,
                    ),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "enter_password".tr(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            width: 500,
                            child: InputTextField(
                              controller: pwdTextController,
                              // decoration: InputDecoration(
                              //   border: OutlineInputBorder(
                              //     borderRadius: BorderRadius.circular(10.0),
                              //   ),
                              hintText: '',
                              keyboardType: TextInputType.text,
                              hideText: false,
                              onChanged: (value) {
                                pwd = value;
                              },
                            ),
                          ),
                        ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Do you confirm this data is accurate?".tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Checkbox(
                                value: isChecked1,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked1 = value!;
                                    isChecked2 = false;
                                  });
                                }),
                            Text("yes_var".tr()),
                            Checkbox(
                                value: isChecked2,
                                onChanged: (bool? value) {
                                  setState(() {
                                    isChecked2 = value!;
                                    isChecked1 = false;
                                  });
                                }),
                            Text("no_var".tr()),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                        child: ElevatedButton(
                          onPressed: () {
                            sendData(name, cnic,phoneNumber, pwd);
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (context) => Confirm(phonenumber: widget.phonenumber,)),
                            );
                          },
                          child: Text(
                            "reg".tr(),
                            style: TextStyle(fontSize: 20),
                          ),
                          style: ButtonStyle(
                            minimumSize:
                            MaterialStateProperty.all(Size(200, 50)),
                          ),
                        )),
                  ]),
            ),
          ),
        ),
      );
    }

}