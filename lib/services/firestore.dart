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
      print("Listening to object");
      var posts = postSnapshot.docs
          .map((snapshot) => Post.fromMap(snapshot.data())).toList();
      _allPagedResults[0] = posts;
      var allPosts = _allPagedResults.fold<List<Post>>([], (initialValue, pageItems) {
        return initialValue..addAll(pageItems);
      });

      postsController.add(allPosts);
    });
    getTimelineStream();
  }


  getTimelineStream() {
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

    var currentRequestIndex = _allPagedResults.length + 1;
    print(currentRequestIndex);
    print(_allPagedResults[0].toString());
    query.snapshots().listen((postSnapshot) {
      if (postSnapshot.docs.isNotEmpty) {
        /*
        print(postSnapshot.docChanges);
        postSnapshot.docChanges.forEach((docChange) {
          print('Type of change: ${docChange.type}');
          print('Document ID: ${docChange.doc.id}');
          print('Document data: ${docChange.doc.data()}');
        });

         */
        if (postSnapshot.docChanges.length < 10) {
          _hasMorePosts = false;
        }
        var posts = postSnapshot.docs
            .map((snapshot) => Post.fromMap(snapshot.data())).toList();

        var pageExists = currentRequestIndex < _allPagedResults.length;
        print(pageExists);
        print(_allPagedResults);
        print(_allPagedResults.length);
        print("here");
        print(_allPagedResults[0][0].creatorUserName);
        if (pageExists) {
          _allPagedResults[currentRequestIndex] = posts;
        } else {
          _allPagedResults.add(posts);
        }

        var allPosts = _allPagedResults.fold<List<Post>>([], (initialValue, pageItems) {
          return initialValue..addAll(pageItems);
        });

        postsController.add(allPosts);

        if (currentRequestIndex == _allPagedResults.length) {
          _lastDocument = postSnapshot.docs.last;
        }

        _hasMorePosts = posts.length == 10;
      }

    });
  }


/*
  Stream<QuerySnapshot> getTimelineStream([DocumentSnapshot? lastDoc]) {
    var friendList = ["iRBSpsuph3QO0ZvRrlp5m1jfX9q1"];
    var query = _firebaseFirestoreInstance
        .collection("posts")
        .where("creator_uid", whereIn: friendList)
        .orderBy('timestamp', descending: true)
        .limit(10);

    if (_lastDocument != null) {
      query = query.startAfterDocument(_lastDocument!);
    }

    var currentRequestIndex = _allPagedResults.length;

    return query.snapshots();
  }

 */

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