import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/FitBuddyPostModel.dart';
import '../../models/user.dart';
import 'firestore_service.dart';

class TimelineServiceFirestore {
  final FirestoreService firestoreService;

  DocumentSnapshot? _lastDocument;
  bool _hasMorePosts = true;
  bool once = false;
  final StreamController<List<Post>> postsController =
      StreamController<List<Post>>.broadcast();

  final List<List<Post>> _allPagedResults = [[]];

  TimelineServiceFirestore({required this.firestoreService});

  @override
  onDispose() {
    postsController.close();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getFirstPost() {
    return firestoreService.instance
        .collection("posts")
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get()
        .then((querySnapshot) => querySnapshot.docs.first);
  }

  void initTimeLine() async {
    var firstPost = await _getFirstPost();
    _lastDocument = firstPost;

    var query = firestoreService.instance
        .collection("posts")
        .orderBy('timestamp', descending: true)
        .endAt([firstPost['timestamp']]);

    query.snapshots().listen((postSnapshot) async {
      var posts = postSnapshot.docs
          .map((snapshot) => Post.fromMap(snapshot.data(), snapshot.id))
          .toList();
      _allPagedResults[0] = posts;

      List<Future<void>> fetchUserFutures = posts.map((post) async {
        var user = await fetchUserData(post.creatorUid);
        if (user != null) {
          post.user = user;
        }
      }).toList();
      await Future.wait(fetchUserFutures);
      // combine multiple lists into one with fold
      var allPosts =
          _allPagedResults.fold<List<Post>>([], (initialValue, pageItems) {
        return initialValue..addAll(pageItems);
      });

      postsController.add(allPosts);
    });
    getMoreTimeLinePosts();
  }

  Future<void> getMoreTimeLinePosts() async {
    print("getMoreTimeLinePosts");
    var friendList = ["iRBSpsuph3QO0ZvRrlp5m1jfX9q1"];
    var query = firestoreService.instance
        .collection("posts")
        .where("creator_uid", whereIn: friendList)
        .orderBy('timestamp', descending: true)
        .limit(10);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    var postSnapshot = await query.get();
    var posts = postSnapshot.docs
        .map((snapshot) => Post.fromMap(snapshot.data(), snapshot.id))
        .toList();

    // Create a list of Futures to fetch user data for each post
    List<Future<void>> fetchUserFutures = posts.map((post) async {
      var user = await fetchUserData(post.creatorUid);
      if (user != null) {
        print("user != null");
        post.user = user;
      }
    }).toList();

    // Wait for all user data fetch operations to complete
    await Future.wait(fetchUserFutures);

    if (posts.isNotEmpty) {
      print("posts.isNotEmpty");
      _allPagedResults.add(posts);
      _lastDocument = postSnapshot.docs.last;
      _hasMorePosts = posts.length == 10;
    }
  }

  Future<User?> fetchUserData(String creatorID) async {
    var userDoc = await firestoreService.instance
        .collection('users')
        .doc(creatorID)
        .get();

    if (userDoc.exists) {
      var userData = userDoc.data() as Map<String, dynamic>;
      return User.fromDataSnapshot(userData);
    }

    return null;
  }

  Future<Post> getSinglePost(String postId) async {
    final docSnapshot =
        await FirebaseFirestore.instance.collection('posts').doc(postId).get();

    if (docSnapshot.exists) {
      return Post.fromMap(docSnapshot.data()!,
          postId); // Assuming you have a named constructor `fromMap` in your `Post` class
    } else {
      throw Exception('Post not found');
    }
  }
}
