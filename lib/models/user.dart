class User {
  //Personal Info
  String name;
  String age;
  String username;
  String? email;
  String? gender;
  bool? accountCompletion;
  String image;
  List<String> friendList = [];
  //Fitness Info
  String? liftingStyle;
  String? gymGoals;
  String? gymExperience;

  User({
    required this.name,
    required this.age,
    required this.gymExperience,
    this.gender,
    this.gymGoals,
    required this.accountCompletion,
    this.liftingStyle,
    required this.username,
    this.email,
    required this.image,
    required this.friendList,
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
      friendList: map['friendList'] ?? [],
      //fitness info
      liftingStyle: map['liftingStyle'],
      gymGoals: map['goals'],
      gymExperience: map['experience'],
    );
  }
}
