import 'package:flutter/material.dart';

class MatchmakingView extends StatelessWidget {
  const MatchmakingView({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Column(
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
      );
  }


}