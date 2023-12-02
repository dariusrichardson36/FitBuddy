import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user.dart';
import '../auth.dart';
import 'firestore_service.dart';

class UserServiceFirestore {
  final FirestoreService firestoreService;
  late User user;

  UserServiceFirestore({required this.firestoreService});

  Future<void> init() async {
    user = await getUserData();
  }

  Future<User> getUserData() async {
    var data = await firestoreService.instance
        .collection('users')
        .doc(Auth().currentUser?.uid)
        .get();
    print("Getting user data");
    print("User data: ${data.data()}");
    print(Auth().currentUser?.uid);
    return User.fromDataSnapshot(data.data()!);
  }

  Future<bool> doesUserDocumentExist(String userId) async {
    // Reference to the "users" collection and the specific document
    DocumentReference userDocRef =
        firestoreService.instance.collection("users").doc(userId);

    // Try to retrieve the document snapshot
    DocumentSnapshot docSnapshot = await userDocRef.get();

    // Check if the document exists
    return docSnapshot.exists;
  }

  void addToFriendList(String friendId) {
    firestoreService.instance
        .collection('users')
        .doc(Auth().currentUser?.uid)
        .update({
      'friendList': FieldValue.arrayUnion([friendId])
    });
  }

  void removeFromFriendList(String friendId) {
    firestoreService.instance
        .collection('users')
        .doc(Auth().currentUser?.uid)
        .update({
      'friendList': FieldValue.arrayRemove([friendId])
    });
  }

  Future<List<String>> searchUser(String name) async {
    try {
      // Ensuring case-insensitive search by converting input and stored name to lowercase
      String lowerCaseName = name.toLowerCase();

      // Using startAt and endAt to get all usernames that start with the search string
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .orderBy('username')
          .startAt([lowerCaseName])
          //.endAt(['$lowerCaseName\uf8ff'])
          //.where('username', isEqualTo: lowerCaseName)
          .get();

      // Extracting usernames from the query snapshot
      List<String> usernames = snapshot.docs.map((doc) {
        return (doc['username'] as String?) ??
            ''; // Adjust if the username is nested or has a different field name
      }).toList();

      return usernames;
    } catch (e) {
      // print("Error in searchUser: $e");
      return [];
    }
  }

  addImage(String url) {
    firestoreService.instance
        .collection('users')
        .doc(Auth().currentUser?.uid)
        .update({
      'images': FieldValue.arrayUnion([url])
    });
  }

  Future createUser(
      String uid,
      String? experience,
      String? goals,
      String? liftingStyle,
      String username,
      String displayName,
      bool isAccountComplete,
      DateTime? dob,
      String? gender) async {
    try {
      await firestoreService.instance.collection('users').doc(uid).set({
        'experience': experience,
        'goals': goals,
        'liftingStyle': liftingStyle,
        'dob': dob,
        'isAccountComplete': isAccountComplete,
        'username': username,
        'displayName': displayName,
        'gender': gender,
        'friendList': [uid],
        'images': [
          "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg"
        ],
        'uid': uid,
      });
    } catch (e) {
      // todo
    }
  }
}
