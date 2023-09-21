import 'package:fit_buddy/pages/home_page.dart';
import 'package:fit_buddy/services/auth.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'auth_page.dart';

final experienceList = <String>["0-3 Months", "6 Months - 1 Year", "1 - 2 Years", "2 - 4 Years", "5 Years+"];
final goalList = <String>["Lose Weight", "Build Muscle", "Build Strength"];
final liftingStyleList = <String>["Calisthenics", "Powerlifting", "Bodybuilding", "Crossfit", "General Health"];

class CompleteAccountInformation extends StatefulWidget {
  const CompleteAccountInformation({super.key});

  @override
  State<StatefulWidget> createState() => _DropDownMenus();
}

class _DropDownMenus extends State<CompleteAccountInformation> {

  String experienceValue = experienceList.first;
  String goalValue = goalList.first;
  String liftingStyleValue = liftingStyleList.first;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text("Give us some more data:"),
          DropdownButton(
            value: experienceValue,
            items: experienceList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                experienceValue = value!;
              });
            },
          ),
          DropdownButton(
            value: goalValue,
            items: goalList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                goalValue = value!;
              });
            },
          ),DropdownButton(
            value: liftingStyleValue,
            items: liftingStyleList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                liftingStyleValue = value!;
              });
            },
          ),
          ElevatedButton(
            child: Text("Submit"),
            onPressed: () async {
              await Firestore().createUser(Auth().currentUser!.uid, experienceValue, goalValue, liftingStyleValue);
              context.go('/homepage');
            }
          )
        ],
      ),
    );
  }
}

