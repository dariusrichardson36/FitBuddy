import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';



class MatchmakingView extends StatelessWidget {
  const MatchmakingView({super.key});

  @override
  Widget build(BuildContext context) {
    return
      Column(
        children: [
          Container(
            width: double.infinity, // Take up the entire screen horizontally
            height: MediaQuery.of(context).size.height * .5, // Take up the top third vertically
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
                  style: GoogleFonts.robotoFlex(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Spacer(), // Spacer widget takes up available space
              Align(
                alignment: Alignment.centerRight, // Right-align the text
                child: Text(
                  '21 ',
                  style: GoogleFonts.robotoFlex(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              // Display the PNG image within the row
              Padding(
                padding: EdgeInsets.only(left: 10.0, right: 5.0), // Adjust the spacing as needed
                child: SizedBox(
                  width: 40, // Set the desired width
                  height: 40, // Set the desired height
                  child: Image.asset(
                    'lib/images/emptyBadge.png', // Replace with the actual asset path
                    fit: BoxFit.contain, // Adjust the fit property as needed
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(right: 5.0), // Adjust the spacing as needed
                child: SizedBox(
                  width: 40, // Set the desired width
                  height: 40, // Set the desired height
                  child: Image.asset(
                    'lib/images/emptyBadge.png', // Replace with the actual asset path
                    fit: BoxFit.contain, // Adjust the fit property as needed
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(right: 5.0), // Adjust the spacing as needed
                child: SizedBox(
                  width: 40, // Set the desired width
                  height: 40, // Set the desired height
                  child: Image.asset(
                    'lib/images/emptyBadge.png', // Replace with the actual asset path
                    fit: BoxFit.contain, // Adjust the fit property as needed
                  ),
                ),
              ),

              SizedBox(
                width: 40, // Set the desired width
                height: 40, // Set the desired height
                child: Image.asset(
                  'lib/images/emptyBadge.png', // Replace with the actual asset path
                  fit: BoxFit.contain, // Adjust the fit property as needed
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Align(
            alignment: Alignment.centerLeft, // Left-align the text
            child: Text(
              '  Gym Experience:',
              style: GoogleFonts.robotoFlex(
                color: Colors.black,
                fontSize: 18,
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
              style: GoogleFonts.robotoFlex(
                color: Colors.black,
                fontSize: 18,
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
              style: GoogleFonts.robotoFlex(
                color: Colors.black,
                fontSize: 18,
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
                    FaIcon(
                      FontAwesomeIcons.dumbbell,
                      size: 56, // Adjust the size as needed
                      color: Colors.red, // Adjust the color as needed
                    ),
                    FaIcon(
                      FontAwesomeIcons.dumbbell,
                      size: 56,
                      color: Colors.green,
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