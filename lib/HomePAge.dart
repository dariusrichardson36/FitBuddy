import 'package:fit_buddy/pages/drawer.dart';
import 'package:fit_buddy/pages/homepage_views/timeline_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData( // This is the theme of your application.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MatchingPage extends StatelessWidget {
  const MatchingPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Matching Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentPageIndex = 0;
  Widget _getScreen(int index) {
    switch (index) {
      case 0:
        return TimelinePage();
      case 1:
        return const MatchingPage();
      default:
        return TimelinePage(); // You can provide a default screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getScreen(_currentPageIndex),
      drawer: Drawer(
        child: DrawerPage(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      bottomNavigationBar: BottomNavigationBar(
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
        ],
        showSelectedLabels: false, // Hide labels for selected item
        showUnselectedLabels: false, // Hide labels for unselected items
      )
    );
  }
}
