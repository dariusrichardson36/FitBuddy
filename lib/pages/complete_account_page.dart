import 'package:fit_buddy/components/FitBuddyDropdownMenu.dart';
import 'package:fit_buddy/pages/home_page.dart';
import 'package:fit_buddy/services/auth.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/my_textfield.dart';
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
  final userNameController = TextEditingController();
  final nameController = TextEditingController();
  int _currentPageIndex = 0;
  final PageController _pageController = PageController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: PageView(
              controller: _pageController,
              children: [
                requiredInformation(),
                personalData()
              ],
            ),
          ),
        ),
      ),
    );
  }

  requiredInformation() {
    final firstDate = DateTime(DateTime.now().year - 120);
    final lastDate = DateTime.now();
    return Column(
      children: [
        Text("Please provide your name, username and date of birth"),
        Text("Don't worry, you can change your name and username at any given time!"),
        MyTextField(
          controller: nameController,
          hintText: 'name',
          obscureText: false,
        ),
        MyTextField(
          controller: userNameController,
          hintText: 'userName',
          obscureText: false,
        ),
        SizedBox(
          height: 10,
        ),
        Text("You need to be at least X years of age to use the FitBuddy App"),
        InputDatePickerFormField(
          firstDate: firstDate,
          lastDate: lastDate,
          fieldLabelText: "Date of birth",
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
                onPressed: () {
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear
                  );
                },
                child: Text("Next")
            )
          ],
        )
      ],

    );
  }

  personalData() {
    return Column(
      children: [
        Text("Give us some more data:"),
        FitBuddyDropdownMenu(
          items: experienceList,
          value: experienceValue,
          onChange: (String? value) {
            setState(() {
              experienceValue = value!;
            });
          }
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
              await Firestore().createUser(
                  Auth().currentUser!.uid,
                  experienceValue,
                  goalValue,
                  liftingStyleValue);
              context.go('/homepage');
            }
        )
      ],
    );
  }
}

