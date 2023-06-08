import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import '../Screens_volunteer/login_signup/models/user_model.dart';

class Database {
  // late String userid;
  // late String userCollection;
  static late String message = '';

  UserModel tempUser = UserModel(
      fullName: '', password: '', phonenumber: '', cnic: '',);

  // setting database collection based on user (donor/ beneficiary)
  // void setUser(String userid) {
  //   if (userid == 'Volunteer') {
  //     userCollection = 'Volunteer';
  //   }
  // }

  Future<String?> addUser({required UserModel user}) async {
    try {
      CollectionReference users =
      FirebaseFirestore.instance.collection('Volunteer');
      // Call the user's CollectionReference to add a new user
      await users.add(user.toJson());
      print('success');
      return 'success';
    } catch (e) {
      return 'Error adding user';
    }
  }

  Future<UserModel?> getUser(String phonenumber) async {
    try {
      print("phone number: $phonenumber");

      final users = FirebaseFirestore.instance.collection('Volunteer');
      final querySnapshot =
      await users.where('phonenumber', isEqualTo: phonenumber).get();

      final List<DocumentSnapshot> documentSnapshots = querySnapshot.docs;

      if (documentSnapshots.isNotEmpty) {
        print("user found!");
        final user =
            querySnapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
        print("data fetched successfully");
        return user;
      } else {
        print("User not Found");
        message = "User not Found";
        return tempUser;
      }
    } catch (e) {
      print("Error Fetching User");
      message = "Error Fetching User";
      return tempUser;
    }
  }

  // Future<String?> editUser({required String userId, required UserModel user}) async {
  // try {
  //   CollectionReference users =
  //       FirebaseFirestore.instance.collection(userCollection);
  //   // Call the user's DocumentReference to update the user data
  //   await users.doc(userId).update(user.toJson());
  //   print('success');
  //   return 'success';
  //   } catch (e) {
  //     return 'Error editing user';
  //   }
  // }

  // Future<String?> editUser({required String phoneNumber, required UserModel user}) async {
  //   try {
  //     print("phonenumber: $phoneNumber");
  //     final users = FirebaseFirestore.instance.collection('Volunteer');
  //     final querySnapshot =
  //     await users.where('phonenumber', isEqualTo: phoneNumber).get();
  //
  //     final List<DocumentSnapshot> documentSnapshots = querySnapshot.docs;
  //
  //     if (documentSnapshots.isNotEmpty) {
  //
  //       final userDocRef = querySnapshot.docs.first.reference;
  //
  //       Map<String, dynamic> user1 = {
  //         'name': user.fullName,
  //         'cnic': user.cnic,
  //         'phonenumber': user.phonenumber,
  //         'city': user.city,
  //         'address': user.address,
  //         'age': user.age,
  //         'gender': user.gender
  //       };
  //
  //       String jsonEncodedUser = json.encode(user1);
  //       print(jsonEncodedUser);
  //
  //       await userDocRef.update(user1);
  //       print('success');
  //       return 'success';
  //     } else {
  //       print("User not found");
  //       return 'User not found';
  //     }
  //   } catch (e) {
  //     return 'Error editing user';
  //   }
  // }


}
