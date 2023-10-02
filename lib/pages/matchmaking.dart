import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserList(group: 'desired_group_name'), // Replace with the actual group name
    );
  }
}

class UserList extends StatelessWidget {
  final String group;

  UserList({required this.group});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users in Group $group'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('group', isEqualTo: group) // Filter users by group
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var userDocs = snapshot.data.docs;

          if (userDocs.isEmpty) {
            return Center(
              child: Text('No users in this group.'),
            );
          }

          return ListView.builder(
            itemCount: userDocs.length,
            itemBuilder: (context, index) {
              var userData = userDocs[index].data();

              return ListTile(
                title: Text('Name: ${userData['name']}'),
                subtitle: Text('Age: ${userData['age']}'),
                // Add more user fields as needed
              );
            },
          );
        },
      ),
    );
  }
}
