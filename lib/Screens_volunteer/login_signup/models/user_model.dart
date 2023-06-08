import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? id;
  late String fullName;
  late String password;
  late String phonenumber;
  late String cnic;
  // late int age;
  // late String city;
  // late String address;
  // late String gender;

  UserModel({
    this.id,
    required this.fullName,
    required this.password,
    required this.phonenumber,
    required this.cnic,
    // required this.age,
    // required this.city,
    // required this.address,
    // required this.gender,

  });

  // Make a setter to set all values and update all values of database
   void setAllFields(
      {required String fullName,
      required String password,
      required String phonenumber,
      required String cnic,
      required int age,
      required String city,
      required String address,
      required String gender}) {
    this.fullName = fullName;
    this.password = password;
    this.phonenumber = phonenumber;
    this.cnic = cnic;
    // this.age = age;
    // this.city = city;
    // this.address = address;
    // this.gender = gender;
  }

  toJson() {
    return {
      "name": fullName,
      "password": password,
      "phonenumber": phonenumber,
      "cnic": cnic,
      // "age": age,
      // "city": city,
      // "address": address,
      // "gender": gender,
    };
  }

  //  from doc to model
  

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
     print("inside from snapshot");
    final data = document.data()!;
    print(data.values);
    return UserModel(
      fullName: data['name'],
      password: data['password'],
      phonenumber: data['phonenumber'],
      cnic: data['cnic'],
      // age: data['age'],
      // city: data['city'],
      // address: data['address'],
      // gender: data['gender'],
    );
  }
}
