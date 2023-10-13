import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_buddy/services/auth.dart';
import 'package:fit_buddy/models/FitBuddyPostModel.dart';

class Firestore {
  final _firebaseFirestoreInstance = FirebaseFirestore.instance;
  DocumentSnapshot? _lastDocument;
  bool _hasMorePosts = true;
  bool once = false;
  final StreamController<List<Post>> postsController =
      StreamController<List<Post>>.broadcast();

  List<List<Post>> _allPagedResults = [[]];


  Future<DocumentSnapshot<Map<String, dynamic>>> getFirstPost() {
    return _firebaseFirestoreInstance
        .collection("posts")
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get()
        .then((querySnapshot) => querySnapshot.docs.first);
  }

  void initTimeLine() async {
    var firstPost = await getFirstPost();
    _lastDocument = firstPost;

    var query = _firebaseFirestoreInstance
        .collection("posts")
        .orderBy('timestamp', descending: true)
        .endAt([firstPost['timestamp']]);

    query.snapshots().listen((postSnapshot) {
      var posts = postSnapshot.docs
          .map((snapshot) => Post.fromMap(snapshot.data(), snapshot.id)).toList();
      _allPagedResults[0] = posts;
      var allPosts = _allPagedResults.fold<List<Post>>([], (initialValue, pageItems) {
        return initialValue..addAll(pageItems);
      });

      postsController.add(allPosts);
    });
    getMoreTimeLinePosts();
  }


  getMoreTimeLinePosts() {
    var friendList = ["iRBSpsuph3QO0ZvRrlp5m1jfX9q1"];
    var query = _firebaseFirestoreInstance
        .collection("posts")
        .where("creator_uid", whereIn: friendList)
        .orderBy('timestamp', descending: true)
        .limit(10);

    if (_hasMorePosts == false) return;

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    var currentRequestIndex = _allPagedResults.length;
    query.snapshots().listen((postSnapshot) {
      if (postSnapshot.docs.isNotEmpty) {
        if (postSnapshot.docChanges.length < 10) {
          _hasMorePosts = false;
        }
        var posts = postSnapshot.docs
            .map((snapshot) => Post.fromMap(snapshot.data(), snapshot.id)).toList();

        var pageExists = currentRequestIndex < _allPagedResults.length;

        if (pageExists) {
          _allPagedResults[currentRequestIndex] = posts;
        } else {
          _allPagedResults.add(posts);
        }

        var allPosts = _allPagedResults.fold<List<Post>>([], (initialValue, pageItems) {
          return initialValue..addAll(pageItems);
        });

        postsController.add(allPosts);

        if (currentRequestIndex + 1 == _allPagedResults.length) {
          _lastDocument = postSnapshot.docs.last;
        }

        _hasMorePosts = posts.length == 10;
      }

    });
  }

  Future<Post> getSinglePost(String postId) async {
    final docSnapshot = await FirebaseFirestore.instance.collection('posts').doc(postId).get();

    if (docSnapshot.exists) {
      return Post.fromMap(docSnapshot.data()!, postId);  // Assuming you have a named constructor `fromMap` in your `Post` class
    } else {
      throw Exception('Post not found');
    }
  }


  getUserData() async {
    return await _firebaseFirestoreInstance.collection('users').doc(Auth().currentUser?.uid).get();
  }

  Future<bool> doesUserDocumentExist(String userId) async {
    // Reference to the "users" collection and the specific document
    DocumentReference userDocRef = _firebaseFirestoreInstance.collection("users").doc(userId);

    // Try to retrieve the document snapshot
    DocumentSnapshot docSnapshot = await userDocRef.get();

    // Check if the document exists
    return docSnapshot.exists;
  }

  Future<List<String>> searchUser(String name) async {
    try {
      // Ensuring case-insensitive search by converting input and stored name to lowercase
      String lowerCaseName = name.toLowerCase();

      // Using startAt and endAt to get all usernames that start with the search string
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .orderBy('username')
          .startAt([lowerCaseName])
          //.endAt(['$lowerCaseName\uf8ff'])
          //.where('username', isEqualTo: lowerCaseName)
          .get();

      // Extracting usernames from the query snapshot
      List<String> usernames = snapshot.docs.map((doc) {
        return (doc['username'] as String?) ?? ''; // Adjust if the username is nested or has a different field name
      }).toList();

      return usernames;
    } catch (e) {
      print("Error in searchUser: $e");
      return [];
    }
  }

  Future createUser(String uid, String? experience, String? goals, String? liftingStyle, String username, String displayName, bool isAccountComplete, DateTime? dob, String? gender) async {
    try {
      await _firebaseFirestoreInstance.collection('users').doc(uid).set({
        'experience': experience,
        'goals': goals,
        'liftingStyle': liftingStyle,
        'dob': dob,
        'isAccountComplete': isAccountComplete,
        'username': username,
        'displayName': displayName,
        'gender': gender,
      });
    } catch (e) {
      // todo
    }
  }

}