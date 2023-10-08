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

  factory Post.fromJson(Map<String, dynamic> json) {
    var activitiesJson = json['activity'] as List;
    List<Activity> activitiesList = activitiesJson.map((i) => Activity.fromJson(i)).toList();
    return Post(
      activities: activitiesList,
      creatorUserName: json['creator_userName'],
      description: json['description'],
      creatorUid: json['creator_uid'],
      timestamp: json['timestamp'],
    );
  }
}
