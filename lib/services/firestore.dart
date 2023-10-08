import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_buddy/services/auth.dart';

class Firestore {
  final _firebaseFirestoreInstance = FirebaseFirestore.instance;

  Future createUser(String uid, String? experience, String? goals, String? liftingStyle, String username, String displayName, bool isAccountComplete, DateTime? dob, String? gender) async {
    try {
      await _firebaseFirestoreInstance.collection('users').doc(uid).set({
        'experience': experience,
        'goals': goals,
        'liftingStyle': liftingStyle,
        'dob': dob,
        'isAccountComplete': isAccountComplete,
        'username': username,
        'displayName': displayName,
        'gender': gender,
      });
    } catch (e) {
      // todo
    }
  }

  Stream<QuerySnapshot> getTimelineStream() {
    var friendList = ["iRBSpsuph3QO0ZvRrlp5m1jfX9q1"];
    return _firebaseFirestoreInstance
        .collection("posts")
        .where("creator_uid", whereIn: ["iRBSpsuph3QO0ZvRrlp5m1jfX9q1"])
        .orderBy('timestamp', descending: true)
        .limit(10)
        .snapshots();
  }

  getUserData() async {
    return await _firebaseFirestoreInstance.collection('users').doc(Auth().currentUser?.uid).get();
  }

  Future<bool> doesUserDocumentExist(String userId) async {
    // Reference to the "users" collection and the specific document
    DocumentReference userDocRef = _firebaseFirestoreInstance.collection("users").doc(userId);

    // Try to retrieve the document snapshot
    DocumentSnapshot docSnapshot = await userDocRef.get();

    // Check if the document exists
    return docSnapshot.exists;
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
        return (doc['username'] as String?) ?? ''; // Adjust if the username is nested or has a different field name
      }).toList();

      return usernames;
    } catch (e) {
      print("Error in searchUser: $e");
      return [];
    }
  }

}