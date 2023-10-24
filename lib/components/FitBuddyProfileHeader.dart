import 'package:fit_buddy/models/user.dart';
import 'package:flutter/material.dart';
import 'package:fit_buddy/constants/color_constants.dart';

class FitBuddyProfileHeader extends StatelessWidget {
    final User userData;

    const FitBuddyProfileHeader({
        super.key,
        required this.userData
      });

    @override
    Widget build(BuildContext context) {
        if (userData.name != null) {
          var name = userData.age;
          return Text(
          name!,
          style: TextStyle(
                color: FitBuddyColorConstants.lOnPrimary,
                fontSize: 25,
                fontWeight: FontWeight.bold
            ),
        );
      }

      return Text('Name is null');
        
    }
}