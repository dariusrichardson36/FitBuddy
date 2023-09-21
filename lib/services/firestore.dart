import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  final _firebaseFirestoreInstance = FirebaseFirestore.instance;

  Future createUser(String uid, String experience, String goals, String liftingStyle) async {
    try {
      await _firebaseFirestoreInstance.collection('users').doc(uid).set({
        'experience': experience,
        'goals': goals,
        'liftingStyle': liftingStyle,
        'age': null,
      });
    } catch (e) {
      // todo
    }
  }

  Future<bool> doesUserDocumentExist(String userId) async {
    // Reference to the "users" collection and the specific document
    DocumentReference userDocRef = FirebaseFirestore.instance.collection("users").doc(userId);

    // Try to retrieve the document snapshot
    DocumentSnapshot docSnapshot = await userDocRef.get();

    // Check if the document exists
    return docSnapshot.exists;
  }

}