import 'package:flutter/cupertino.dart';

import '../../components/FitBuddySelectableButton.dart';

class GenderSelection extends StatefulWidget {
  const GenderSelection({super.key});

  @override
  _GenderSelectionState createState() => _GenderSelectionState();
}

class _GenderSelectionState extends State<GenderSelection> {
  bool isManSelected = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("I am a", style: TextStyle(fontSize: 20),),
        SizedBox(height: 20),
        FitBuddySelectableButton(
          text: "MAN",
          onTap: () {
            setState(() {
              isManSelected = true;
            });
          },
          isSelected: !isManSelected,
        ),
        SizedBox(height: 20),
        FitBuddySelectableButton(
          text: "WOMAN",
          onTap: () {
            setState(() {
              isManSelected = false;
            });
          },
          isSelected: isManSelected,
        ),
      ],
    );
  }
}