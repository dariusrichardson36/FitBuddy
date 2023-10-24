import 'package:cloud_firestore/cloud_firestore.dart';

class User
{
  //Personal Info
  String? displayName;
  String? username;
  String? image_url;
  String? age;
  String? email;

  //Fitness Info
  String? liftingStyle;
  String? goals;
  String? experience;

  User({
    this.displayName,
    this.username,
    this.age,
    this.image_url,
    this.email,
    this.liftingStyle,
    this.goals,
    this.experience,
});

  static User fromDataSnapshot(DocumentSnapshot snapshot){
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;

    return User(
      //personal info
      displayName: dataSnapshot['displayName'],
      username: dataSnapshot['username'],
      image_url: dataSnapshot['image_url'],
      age: dataSnapshot['age'],
      email: dataSnapshot['email'],

      //fitness info
      liftingStyle: dataSnapshot['liftingStyle'],
      goals: dataSnapshot['goals'],
      experience: dataSnapshot['experience'],
    );
  }

  Map<String,dynamic> toJson() => {
    //personal info
    "displayName": displayName,
    "username": username,
    "image_url": image_url,
    "age": age,
    "email": email,

    //fitness info
    "liftingStyle": liftingStyle,
    "goals": goals,
    "experience": experience,
  };
}