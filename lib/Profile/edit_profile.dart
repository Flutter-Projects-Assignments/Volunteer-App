import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/constants.dart';
import 'ProfileVolunteer.dart';
import 'package:flutter/material.dart';
import '../models/database.dart';
// import user model
import '../Screens_volunteer/login_signup/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class EditProfile extends StatefulWidget {
  // EditProfile({Key? key}) : super(key: key);
  static const id = "edit_profile";
  late final dynamic userDetails;

  EditProfile({this.userDetails});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late String name;
  //late int age;
  late String city;
  late String gender;
  late String address;
  late String cnic;
  late String phonenumber;

  // Database db = Database();

  @override
  void initState() {
    super.initState();
    // print("widget.userDetails");
    // print(widget.userDetails);

    //   name = userDetails.fullName;
    //   age = widget.userDetails.age;
    //   city = widget.userDetails.city;
    //   gender = widget.userDetails.gender;
    //   profession = widget.userDetails.profession;
    //   address = widget.userDetails.address;
    //   DOB = widget.userDetails.DOB;
    //   cnic = widget.userDetails.cnic;
    //   phonenumber = widget.userDetails.phonenumber;
  }

  // void getUserDetails() async {
  //   final dynamic user = await ModalRoute.of(context)?.settings.arguments;
  //   if (user != null) {
  //     setState(() {
  //       name = user.fullName;
  //       age = user.age;
  //       city = user.city;
  //       gender = user.gender;
  //       profession = user.profession;
  //       address = user.address;
  //       DOB = user.DOB;
  //       cnic = user.cnic;
  //       phonenumber = user.phonenumber;
  //     });
  //   }
  // }

// @override
// void didChangeDependencies() {
//   super.didChangeDependencies();

//   final dynamic userDetails =  ModalRoute.of(context)?.settings.arguments;
//   name = userDetails?.fullName ?? 'name';
//   age = userDetails?.age ?? 0;
//   city = userDetails?.city ?? 'city';
//   gender = userDetails?.gender ?? 'gender';
//   profession = userDetails?.profession ?? 'profession';
//   address = userDetails?.address ?? 'address';
//   DOB = userDetails?.DOB ?? 'DOB';
//   cnic = userDetails?.cnic ?? 'cnic';
//   phonenumber = userDetails?.phonenumber ?? 'phonenumber';

// }

  @override
  Widget build(BuildContext context) {
    final dynamic userDetails = ModalRoute.of(context)?.settings.arguments;
    print("user details are ${userDetails.donatedZakat} and ${userDetails.donatedSadqah}");
    name = userDetails?.fullName ?? 'name';
    //age = userDetails?.age ?? 0;
    city = userDetails?.city ?? 'city';
    gender = userDetails?.gender ?? 'gender';
    address = userDetails?.address ?? 'address';
    cnic = userDetails?.cnic ?? 'cnic';
    phonenumber = userDetails?.phonenumber ?? 'phonenumber';

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: kTextColor),
          centerTitle: true,
          title: const Text(
            'Edit Profile',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          backgroundColor: kBackgroundColor,
          actions: const [
            Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: kTextColor),
                  ),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Expanded(
                  child: inputType1(
                    label: "Name",
                    hint: name,
                    data: name,
                    onChanged: (value) {
                      name = value;
                    },
                  )),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: inputType1(
                        label: "City",
                        hint: city,
                        data: city,
                        onChanged: (value) {
                          city = value;
                        },
                      )),
                ],
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: inputType1(
                        label: "Gender",
                        hint: gender,
                        data: gender,
                        onChanged: (value) {
                          gender = value;
                        },
                      )),
                  SizedBox(width: 30),
                  //Expanded(
                    //  child: inputType1(
                     //   label: "Profession",
                     //   hint: profession,
                       // data: profession,
                      //  onChanged: (value) {
                      //    profession = value;
                        //},
                     // )),
                ],
              ),
              SizedBox(height: 30),
              // inputType1(
              //   label: "Date of Birth",
              //   hint: DOB,
              //   data: DOB,
              //   onChanged: (value) {
              //     DOB = value;
              //   },
              // ),
              SizedBox(height: 20),
              Divider(color: kLightGray, thickness: 1),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: inputType2(label: "CNIC", data: cnic,hint: cnic,)),
                  SizedBox(width: 30),
                  Expanded(
                      child:
                      inputType2(label: "Phone Number", data: phonenumber,hint: phonenumber,)),
                ],
              ),
              SizedBox(height: 30),
              inputType2(label: "Address", data: address,hint: address,),
              SizedBox(height: 30),
              TextButton(
                onPressed: () async {
                  print("User Details before are ${userDetails.age}");
                  userDetails.fullName = name;
                  //userDetails.age = age;
                  userDetails.city = city;
                  userDetails.cnic = cnic;
                  userDetails.phonenumber = phonenumber;
                  userDetails.address = address;
                  print("User Details after are ${userDetails}");

                  final db = FirebaseFirestore.instance;

                  // fetch user with phone number and update
                  final QuerySnapshot result = await db
                      .collection('Volunteers')
                      .where('phonenumber', isEqualTo: userDetails.phonenumber)
                      .get();
                  // get first document from result
                  final List<DocumentSnapshot> documents = result.docs;
                  if (documents.isNotEmpty) {
                    // update user
                    await db
                        .collection('Volunteers')
                        .doc(documents[0].id)
                        .update(userDetails.toJson());
                  }

                  // Navigator.pop(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => Profile(), settings: RouteSettings(arguments: userDetails)));
                },
                child: Text('Save Changes'),
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class inputType1 extends StatelessWidget {
  String label = "";
  dynamic data = "";
  String hint = "";
  ValueChanged<String> onChanged;

  inputType1(
      {required this.label, required this.data, required this.onChanged,required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: kLightPrimaryColor,
        labelText: label,
        labelStyle: TextStyle(color: kTextColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kLightGray),
          borderRadius: BorderRadius.circular(20),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: kLightGray),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (value) {
        print(value);
        // this.data = value;
        onChanged(value);
      },
    );
  }
}

class inputType2 extends StatelessWidget {
  String label = "";
  dynamic data = "";
  String hint = "";
  inputType2({required this.label, required this.data,required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextField(

      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        labelStyle: const TextStyle(color: kTextColor),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kLightGray),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: kLightGray),
        ),
      ),
      onChanged: (value) {
        print(value);
        this.data = value;
      },
    );
  }
}

