import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MatchScreen(), // Set MatchScreen as the initial and only screen
    );
  }
}

class MatchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discover',
          style: TextStyle(
            fontSize: 45.0,
            fontWeight: FontWeight.bold
          )
        ), // Set the app bar title to "Discover"
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity, // Take up the entire screen horizontally
            height: MediaQuery.of(context).size.height * .4, // Take up the top third vertically
            color: Colors.lightBlue,
          ),
          // Rest of your content goes here
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Spacing between children
            children: [
              Align(
                alignment: Alignment.centerLeft, // Left-align the text
                child: Text(
                  ' Matthew',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(), // Spacer widget takes up available space
              Align(
                alignment: Alignment.centerRight, // Right-align the text
                child: Text(
                  'Age ',
                  style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Align(
            alignment: Alignment.centerLeft, // Left-align the text
            child: Text(
              '  Gym Experience:',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
           // Add vertical spacing between text fields
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft, // Left-align the text
            child: Text(
              '  Gym Goals:',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
           // Add vertical spacing between text fields
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft, // Left-align the text
            child: Text(
              '  Lifting Style:',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

      Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end, // Align the inner column to the bottom
          children: [
            // Inner column widgets go here
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Icon(
                  Icons.thumb_down, // Placeholder icon for "yes"
                  size: 60.0, // Adjust the size as needed
                  color: Colors.red, // Adjust the color as needed
                ),
                Icon(
                  Icons.thumb_up, // Placeholder icon for "no"
                  size: 60.0, // Adjust the size as needed
                  color: Colors.green, // Adjust the color as needed
                ),
              ],
            ),
          ],
        ),
      ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
        IconButton(
        icon: Icon(Icons.home),
        onPressed: () {
          // Handle the Home feature here
        },
      ),
      IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          // Handle the Search feature here
        },
      ),
      IconButton(
        icon: Icon(Icons.message),
        onPressed: () {
          // Handle the Messages feature here
        },
      ),
      IconButton(
        icon: Icon(Icons.settings),
        onPressed: () {
          // Handle the Settings feature here
        },
      ),
      ],
        ),
      ),
    );
  }
}


