import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import 'models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  /// Store User in Firestore
  createUser(UserModel user) async {}

  /// Fetch User Details
  Future<UserModel> getUserDetails(String phone) async {
    final snapshot = await _db
        .collection('Users')
        .where('phonenumber', isEqualTo: phone)
        .get();
    final userData = snapshot.docs.map((e) => UserModel.fromSnapshot(e)).single;
    print(userData.phonenumber);
    return userData;
  }

  Future<List<UserModel>> allUser() async {
    final snapshot = await _db.collection('Users').get();
    final userData =
        snapshot.docs.map((e) => UserModel.fromSnapshot(e)).toList();
    return userData;
  }
}
