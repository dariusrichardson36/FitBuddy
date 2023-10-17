import 'package:cloud_firestore/cloud_firestore.dart';

class User
{
  //Personal Info
  String? displayName;
  String? username;
  String? age;
  String? email;

  //Fitness Info
  String? liftingStyle;
  String? gymGoals;
  String? gymExperience;

  User({
    this.displayName,
    this.username,
    this.age,
    this.email,
    this.liftingStyle,
    this.gymGoals,
    this.gymExperience,
});

  static User fromDataSnapshot(DocumentSnapshot snapshot){
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;

    return User(
      //personal info
      displayName: dataSnapshot['displayName'],
      username: dataSnapshot['username'],
      age: dataSnapshot['age'],
      email: dataSnapshot['email'],

      //fitness info
      liftingStyle: dataSnapshot['liftingStyle'],
      gymGoals: dataSnapshot['gymGoals'],
      gymExperience: dataSnapshot['gymExperience'],
    );
  }

  Map<String,dynamic> toJson() => {
    //personal info
    "displayName": displayName,
    "username": username,
    "age": age,
    "email": email,

    //fitness info
    "liftingStyle": liftingStyle,
    "gymGoals": gymGoals,
    "gymExperience": gymExperience,
  };
}