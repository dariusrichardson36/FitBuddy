import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_buddy/models/user.dart';
import 'package:fit_buddy/services/auth.dart';

import '../../models/FitBuddyPostModel.dart';
import 'firestore_service.dart';

class ProfileServiceFirestore {
  final FirestoreService firestoreService;

  DocumentSnapshot? _lastDocument;
  bool _hasMorePosts = true;
  bool once = false;
  final List _streams = [];
  final StreamController<List<Post>> postsController =
      StreamController<List<Post>>.broadcast();

  final List<List<Post>> _allPagedResults = [[]];

  ProfileServiceFirestore({required this.firestoreService});

  @override
  onDispose() {
    postsController.close();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> _getFirstUserPost(
      String? uid) {
    return firestoreService.instance
        .collection("posts")
        .where('creator_uid', isEqualTo: uid)
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get()
        .then((querySnapshot) => querySnapshot.docs.first);
  }

  void initProfile(String? uid) async {
    var firstPost = await _getFirstUserPost(uid);
    _lastDocument = firstPost;

    var query = firestoreService.instance
        .collection("posts")
        .where('creator_uid', isEqualTo: uid)
        .orderBy('timestamp', descending: true)
        .endAt([firstPost['timestamp']]);

    query.snapshots().listen((postSnapshot) {
      var posts = postSnapshot.docs
          .map((snapshot) => Post.fromMap(snapshot.data(), snapshot.id))
          .toList();
      _allPagedResults[0] = posts;
      var allPosts =
          _allPagedResults.fold<List<Post>>([], (initialValue, pageItems) {
        return initialValue..addAll(pageItems);
      });

      postsController.add(allPosts);
    });
    getMoreUserPosts(uid);
  }

  getMoreUserPosts(String? uid) {
    var query = firestoreService.instance
        .collection("posts")
        .where('creator_uid', isEqualTo: uid)
        .orderBy('timestamp', descending: true)
        .limit(10);

    if (_hasMorePosts == false) return;

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    var currentRequestIndex = _allPagedResults.length;
    var test = query.snapshots().listen((postSnapshot) {
      if (postSnapshot.docs.isNotEmpty) {
        if (postSnapshot.docChanges.length < 10) {
          _hasMorePosts = false;
        }
        var posts = postSnapshot.docs
            .map((snapshot) => Post.fromMap(snapshot.data(), snapshot.id))
            .toList();

        var pageExists = currentRequestIndex < _allPagedResults.length;

        if (pageExists) {
          _allPagedResults[currentRequestIndex] = posts;
        } else {
          _allPagedResults.add(posts);
        }

        var allPosts =
            _allPagedResults.fold<List<Post>>([], (initialValue, pageItems) {
          return initialValue..addAll(pageItems);
        });

        postsController.add(allPosts);

        if (currentRequestIndex + 1 == _allPagedResults.length) {
          _lastDocument = postSnapshot.docs.last;
        }

        _hasMorePosts = posts.length == 10;
      }
    });
    _streams.add(test);
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

  Future<User> getUserData() async {
    final docSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(Auth().currentUser?.uid)
        .get();

    if (docSnapshot.exists) {
      return User.fromDataSnapshot(docSnapshot.data()!);
    } else {
      throw Exception('User not found');
    }
  }
}
