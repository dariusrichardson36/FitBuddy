import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:fit_buddy/models/user.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController
{
  final Rx<List<User>> usersProfileList = Rx<List<User>>([]);
  List<User> get allUsersProfileList => usersProfileList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    usersProfileList.bindStream(
      FirebaseFirestore.instance.collection("testUsers")
          .where("uid", isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .snapshots().map((QuerySnapshot queryDataSnapshot)
      {
        List<User> usersList = [];

        for(var eachUser in queryDataSnapshot.docs)
          {
            usersList.add(User.fromDataSnapshot(eachUser));
          }
        return usersList;
      })
    );
  }
}

