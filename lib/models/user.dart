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

  static User fromDataSnapshot(DocumentSnapshot snapshot){
    var dataSnapshot = snapshot.data() as Map<String, dynamic>;

    return User(
      //personal info
      name: dataSnapshot['name'],
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