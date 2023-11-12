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
  String? uid;
  List<String> images = [
    "https://firebasestorage.googleapis.com/v0/b/fitbuddy-85955.appspot.com/o/profileImages%2FiRBSpsuph3QO0ZvRrlp5m1jfX9q1%2FIMG_20230712_150044.jpg?alt=media&token=ed2480ea-6b63-4a45-b72e-28a12dc291af",
    "https://firebasestorage.googleapis.com/v0/b/fitbuddy-85955.appspot.com/o/profileImages%2FiRBSpsuph3QO0ZvRrlp5m1jfX9q1%2FIMG-20230210-WA0004.jpg?alt=media&token=92acc894-a000-4c2a-9a8e-0504975cb761",
    "https://firebasestorage.googleapis.com/v0/b/fitbuddy-85955.appspot.com/o/profileImages%2FiRBSpsuph3QO0ZvRrlp5m1jfX9q1%2FIMG-20220818-WA0008.jpg?alt=media&token=2205b684-c281-4466-a516-14d965e5ee5d"
  ];

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
    this.uid,
  });

  static User fromDataSnapshot(Map<String, dynamic> map) {
    return User(
      //personal info
      name: map['displayName'],
      age: map['dob'],
      username: map['username'],
      email: map['email'],
      image: map['image_url'] ??
          "https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg",
      gender: map['gender'],
      accountCompletion: map['isAccountComplete'],
      friendList: List<String>.from(map["friendList"]),
      //fitness info
      liftingStyle: map['liftingStyle'],
      gymGoals: map['goals'],
      gymExperience: map['experience'],
    );
  }
}
