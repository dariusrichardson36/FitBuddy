import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  final _firebaseFirestoreInstance = FirebaseFirestore.instance;

  Future createUser(String uid, String experience, String goals, String liftingStyle) async {
    try {
      await _firebaseFirestoreInstance.collection('users').doc(uid).set({
        'experience': experience,
        'goals': goals,
        'liftingStyle': liftingStyle,
      });
    } catch (e) {
      // todo
    }
  }

}