import 'package:cloud_firestore/cloud_firestore.dart';

import 'FitBuddyActivityModel.dart';

class Post {
  final List<Activity> activities;
  final String creatorUserName;
  final String description;
  final String creatorUid;
  final Timestamp timestamp;

  Post({
    required this.activities,
    required this.creatorUserName,
    required this.description,
    required this.creatorUid,
    required this.timestamp,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    var activitiesJson = map['activities'];
    List<Activity> activitiesList = activitiesJson.map<Activity>((i) => Activity.fromMap(i)).toList();
    return Post(
      activities: activitiesList,
      creatorUserName: map['creator_userName'],
      description: map['description'],
      creatorUid: map['creator_uid'],
      timestamp: map['timestamp'],
    );
  }
}
