import 'package:cloud_firestore/cloud_firestore.dart';

class User
{
  String? uid;

  //Personal Info
  String? displayName;
  String? username;
  String? image_url;
  //String? dob;
  String? email;

  //Fitness Info
  String? liftingStyle;
  String? gymGoals;
  String? liftingExperience;

  User({
    this.uid,
    this.displayName,
    this.username,
    //this.dob,
    this.image_url,
    this.email,
    this.liftingStyle,
    this.gymGoals,
    this.liftingExperience,
});

  static User fromDataSnapshot(DocumentSnapshot snapshot){
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;

    return User(

      uid: dataSnapshot['uid'],
      //personal info
      displayName: dataSnapshot['displayName'],
      username: dataSnapshot['username'],
      image_url: dataSnapshot['image_url'],
      //dob: dataSnapshot['dob'],
      email: dataSnapshot['email'],

      //fitness info
      liftingStyle: dataSnapshot['liftingStyle'],
      gymGoals: dataSnapshot['gymGoals'],
      liftingExperience: dataSnapshot['liftingExperience'],
    );
  }

  Map<String,dynamic> toJson() => {

    "uid": uid,
    //personal info
    "displayName": displayName,
    "username": username,
    "image_url": image_url,
    //"dob": dob,
    "email": email,

    //fitness info
    "liftingStyle": liftingStyle,
    "gymGoals": gymGoals,
    "liftingExperience": liftingExperience,
  };
}