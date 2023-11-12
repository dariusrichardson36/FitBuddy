import 'package:cloud_firestore/cloud_firestore.dart';

import 'FitBuddyActivityModel.dart';

class Post {
  final List<Activity> workout;
  final String creatorUserName;
  final String description;
  final String creatorUid;
  final Timestamp timestamp;
  final String postId;

  Post({
    required this.workout,
    required this.creatorUserName,
    required this.description,
    required this.creatorUid,
    required this.timestamp,
    required this.postId,
  });

  factory Post.fromMap(Map<String, dynamic> map, String id) {
    var activitiesJson = map['activities'];
    List<Activity> activitiesList = activitiesJson.map<Activity>((i) => Activity.fromMap(i)).toList();
    return Post(
      workout: activitiesList,
      creatorUserName: map['creator_userName'],
      description: map['description'] ?? '',
      creatorUid: map['creator_uid'],
      timestamp: map['timestamp'],
      postId: id,
    );
  }
}
