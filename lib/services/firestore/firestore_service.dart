import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_buddy/services/firestore/post_service_firestore.dart';
import 'package:fit_buddy/services/firestore/timeline_service_firestore.dart';

import 'auth_service_firestore.dart';


class FirestoreService {
  final FirebaseFirestore _firebaseFirestoreInstance = FirebaseFirestore.instance;

  FirebaseFirestore get instance => _firebaseFirestoreInstance;

  late final AuthServiceFirestore authService;
  late final TimelineServiceFirestore timelineService;
  late final PostServiceFirestore postService;

  FirestoreService() {
    authService = AuthServiceFirestore(firestoreService: this);
    timelineService = TimelineServiceFirestore(firestoreService: this);
    postService = PostServiceFirestore(firestoreService: this);
  }
}

final FirestoreService firestoreServices = FirestoreService();

/*
firestoreServices.authService.someAuthMethod();
firestoreServices.timelineService.someTimelineMethod();
firestoreServices.postService.somePostMethod();


 */
}