import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_buddy/pages/complete_account_page.dart';
import 'package:fit_buddy/pages/homepage_views/achievements_view.dart';
import 'package:fit_buddy/services/auth.dart';
import 'package:flutter/material.dart';
import '../services/firestore.dart';
import 'drawer.dart';
import 'homepage_views/timeline_view.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final user = FirebaseAuth.instance.currentUser!;
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();

  succes() {
    return Center(child: Text("Logged In!}"));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: DrawerPage(),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          TimeLineView(),
          achievementsView(),
        ],

      ),
      bottomNavigationBar: fitBuddyBottomNavigationBar(),
    );
  }

  fitBuddyBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: _currentPageIndex,
      onTap: (index) => setState(() => _currentPageIndex = index),
      //selectedItemColor: Colors.black,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.local_fire_department_rounded),
          label: 'Matching',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.leaderboard),
          label: 'Leaderboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.email),
          label: 'messages',
        ),
      ],
      showSelectedLabels: false, // Hide labels for selected item
      showUnselectedLabels: false, // Hide labels for unselected items
    );
  }

}