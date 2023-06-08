// import 'dart:convert';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:donor_app/screens/login_signup/models/beneficiary_user_model.dart';
// import 'package:donor_app/screens/login_signup/models/user_model.dart';
//
// class BeneficiaryDatabase {
//   // late String userid;
//   late String userCollection;
//   static late String message = '';
//
//   BeneficiaryUserModel tempUser = BeneficiaryUserModel(
//     userId: '',
//     fullName: '',
//     password: '',
//     phonenumber: '',
//     cnic: '',
//   );
//
//   // setting database collection based on user (donor/ beneficiary)
//   void setUser(String userid) {
//     if (userid == 'donor') {
//       userCollection = 'Donors';
//     } else if (userid == 'beneficiary') {
//       userCollection = 'Beneficiaries';
//       print(userCollection);
//     }
//   }
//
//   Future<String?> addUser({required BeneficiaryUserModel user}) async {
//     try {
//       CollectionReference users =
//           FirebaseFirestore.instance.collection('Beneficiaries');
//       // Call the user's CollectionReference to add a new user
//       await users.add(user.toJson());
//       print('success');
//       return 'success';
//     } catch (e) {
//       return 'Error adding user';
//     }
//   }
//
//   Future<BeneficiaryUserModel?> getUser(String phonenumber) async {
//     print(phonenumber);
//     try {
//       print("phone number: $phonenumber");
//
//       final users = FirebaseFirestore.instance.collection('Beneficiaries');
//       print("Users $users");
//       final querySnapshot =
//           await users.where('phonenumber', isEqualTo: phonenumber).get();
//       print(querySnapshot);
//       final List<DocumentSnapshot> documentSnapshots = querySnapshot.docs;
//       print(querySnapshot.docs);
//
//       if (documentSnapshots.isNotEmpty) {
//         print("beneficiary found!");
//
//         // error in this line for beneficiaries user.
//         final user = querySnapshot.docs
//             .map((e) => BeneficiaryUserModel.fromSnapshot(e))
//             .single;
//         print("data fetched successfully");
//         return user;
//       } else {
//         print("User not Found");
//         message = "User not Found";
//         return tempUser;
//       }
//     } catch (e) {
//       print("Error Fetching User");
//       message = "Error Fetching User";
//       return tempUser;
//     }
//   }
//
//   // Future<String?> editUser({required String userId, required UserModel user}) async {
//   // try {
//   //   CollectionReference users =
//   //       FirebaseFirestore.instance.collection(userCollection);
//   //   // Call the user's DocumentReference to update the user data
//   //   await users.doc(userId).update(user.toJson());
//   //   print('success');
//   //   return 'success';
//   //   } catch (e) {
//   //     return 'Error editing user';
//   //   }
//   // }
//
//   Future<String?> editUser(
//       {required String phoneNumber, required BeneficiaryUserModel user}) async {
//     try {
//       print("phonenumber: $phoneNumber");
//       final users = FirebaseFirestore.instance.collection(userCollection);
//       final querySnapshot =
//           await users.where('phonenumber', isEqualTo: phoneNumber).get();
//
//       final List<DocumentSnapshot> documentSnapshots = querySnapshot.docs;
//
//       if (documentSnapshots.isNotEmpty) {
//         final userDocRef = querySnapshot.docs.first.reference;
//
//         Map<String, dynamic> user1 = {
//           'name': user.fullName,
//           'cnic': user.cnic,
//           'phonenumber': user.phonenumber,
//         };
//
//         String jsonEncodedUser = json.encode(user1);
//         print(jsonEncodedUser);
//
//         await userDocRef.update(user1);
//         print('success');
//         return 'success';
//       } else {
//         print("User not found");
//         return 'User not found';
//       }
//     } catch (e) {
//       return 'Error editing user';
//     }
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Screens_volunteer/login_signup/models/user_model.dart';

class VolDatabase {
  // late String userid;
  late String userCollection;
  static late String message = '';

  UserModel tempUser = UserModel(
      //userId: '',
      fullName: '',
      password: '',
      phonenumber: '',
      cnic: '',
      );

  // setting database collection based on user (donor/ beneficiary)
  // void setUser(String userid) {
  //   if (userid == 'donor') {
  //     userCollection = 'Donors';
  //   } else if (userid == 'beneficiary') {
  //     userCollection = 'Beneficiaries';
  //   }
  // }

  Future<String?> addUser({required UserModel user}) async {
    try {
      CollectionReference users =
      FirebaseFirestore.instance.collection('VerifiedVolunteers');
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
      final users = FirebaseFirestore.instance.collection('VerifiedVolunteers');
      final querySnapshot =
      await users.where('phonenumber', isEqualTo: phonenumber).get();

      final List<DocumentSnapshot> documentSnapshots = querySnapshot.docs;

      if (documentSnapshots.isNotEmpty) {
        print("yahan aya 333");
        final user = querySnapshot.docs
            .map((e) => UserModel.fromSnapshot(e))
            .single;
        print("data fetched successfully");
        return user;
      } else {
        print("yahan aya11");
        message = "User not Found";
        return tempUser;
      }
    } catch (e) {
      print("error");
      message = "Error Fetching User";
      return tempUser;
    }
  }
}
