import 'package:cloud_firestore/cloud_firestore.dart';

class User
{
  //Personal Info
  String? name;
  String? username;
  String? age;
  String? email;

  //Fitness Info
  String? liftingStyle;
  String? gymGoals;
  String? gymExperience;

  User({
    this.name,
    this.username,
    this.age,
    this.email,
    this.liftingStyle,
    this.gymGoals,
    this.gymExperience,
});

  static User fromDataSnapshot(Map<String, dynamic> map){
    //var dataSnapshot = snapshot.data() as Map<String, dynamic>;

    return User(
      //personal info
      name: map['name'],
      username: map['username'],
      age: map['age'],
      email: map['email'],

      //fitness info
      liftingStyle: map['liftingStyle'],
      gymGoals: map['gymGoals'],
      gymExperience: map['gymExperience'],
    );
  }

  Map<String,dynamic> toJson() => {
    //personal info
    "name": name,
    "username": username,
    "age": age,
    "email": email,

    //fitness info
    "liftingStyle": liftingStyle,
    "gymGoals": gymGoals,
    "gymExperience": gymExperience,
  };
}