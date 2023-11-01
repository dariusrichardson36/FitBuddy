import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_buddy/services/firestore/post_service_firestore.dart';
import 'package:fit_buddy/services/firestore/profile_service_firestore.dart';
import 'package:fit_buddy/services/firestore/timeline_service_firestore.dart';

import 'auth_service_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firebaseFirestoreInstance = FirebaseFirestore.instance;

  FirebaseFirestore get instance => _firebaseFirestoreInstance;

  late final UserServiceFirestore userService;
  late final TimelineServiceFirestore timelineService;
  late final PostServiceFirestore postService;
  late final ProfileServiceFirestore profileService;

  // 1. Static instance of the class
  static final FirestoreService _instance = FirestoreService._internal();

  // 2. Factory constructor returning the static instance
  factory FirestoreService.firestoreService() {
    return _instance;
  }

  // 3. Internal named constructor
  FirestoreService._internal() {
    userService = UserServiceFirestore(firestoreService: this);
    timelineService = TimelineServiceFirestore(firestoreService: this);
    postService = PostServiceFirestore(firestoreService: this);
    profileService = ProfileServiceFirestore(firestoreService: this);
  }
}
