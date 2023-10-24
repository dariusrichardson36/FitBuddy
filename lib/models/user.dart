import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  //Personal Info
  String? name;
  Timestamp? age;
  String? username;
  String? email;
  String? gender;
  bool? accountCompletion;
  String? image;

  //Fitness Info
  String? liftingStyle;
  String? gymGoals;
  String? gymExperience;

  User({
    this.name,
    this.age,
    this.gymExperience,
    this.gender,
    this.gymGoals,
    this.accountCompletion,
    this.liftingStyle,
    this.username,
    this.email,
    this.image,
  });

  static User fromDataSnapshot(Map<String, dynamic> map) {
    return User(
      //personal info
      name: map['displayName'],
      age: map['dob'],
      username: map['username'],
      email: map['email'],
      image: map['image_url'],
      gender: map['gender'],
      accountCompletion: map['isAccountComplete'],

      //fitness info
      liftingStyle: map['liftingStyle'],
      gymGoals: map['goals'],
      gymExperience: map['experience'],
    );
  }
}
