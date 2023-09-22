import 'package:fit_buddy/components/FitBuddyDropdownMenu.dart';
import 'package:fit_buddy/pages/home_page.dart';
import 'package:fit_buddy/services/auth.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/FitBuddyTextFormField.dart';
import 'auth_page.dart';

final experienceList = <String>["Choose your experience", "0-3 Months", "6 Months - 1 Year", "1 - 2 Years", "2 - 4 Years", "5 Years+"];
final goalList = <String>["Choose your goal", "Lose Weight", "Build Muscle", "Build Strength"];
final liftingStyleList = <String>["Choose your lifting style", "Calisthenics", "Powerlifting", "Bodybuilding", "Crossfit", "General Health"];

class CompleteAccountInformationOld extends StatefulWidget {
  const CompleteAccountInformationOld({super.key});

  @override
  State<StatefulWidget> createState() => _DropDownMenus();
}

class _DropDownMenus extends State<CompleteAccountInformationOld> {

  String experienceValue = experienceList.first;
  String goalValue = goalList.first;
  String liftingStyleValue = liftingStyleList.first;
  final userNameController = TextEditingController();
  final nameController = TextEditingController();
  final PageController _pageController = PageController();
  final firstDate = DateTime(DateTime.now().year - 100);
  final lastDate = DateTime.now();
  DateTime? selectedDate;
  String _errorMessage = "";

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    )) ?? DateTime.now();

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: PageView(
              physics: NeverScrollableScrollPhysics(),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Please provide your name, username and date of birth"),
        Text("Don't worry, you can change your name and username at any given time!"),
        SizedBox(
          height: 10,
        ),
        FitBuddyTextFormField(
          controller: nameController,
          hintText: 'name',
          obscureText: false,
        ),
        FitBuddyTextFormField(
          controller: userNameController,
          hintText: 'username',
          obscureText: false,
        ),
        SizedBox(
          height: 10,
        ),
        GestureDetector(
            onTap: () {
              _selectDate(context);
            },
            child: Text("You need to be at least X years of age to use the FitBuddy App")),
        GestureDetector(
          onTap: () async {
            print("object");
            // Show the date picker dialog
            _selectDate(context);
          },
          child: InputDatePickerFormField(
            onDateSaved: (value) => print(value),
            onDateSubmitted: (value) => print("submitted" + value.toString()) ,
            acceptEmptyDate: false,
            errorFormatText: "Invalid date format",
            errorInvalidText: "Invalid text",
            firstDate: firstDate,
            lastDate: lastDate,
            fieldLabelText: "Date of birth",
          ),
        ),

        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            errorMessage(),
            ElevatedButton(
                onPressed: () {
                  nextPage();
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Please provide us with more data so we can match you to the right people."),
        Text("Don't worry, you can always do this later or change it."),
        SizedBox(
          height: 10,
        ),
        Text("What is your fitness experience"),
        FitBuddyDropdownMenu(
            items: experienceList,
            value: experienceValue,
            onChange: (String? value) {
              setState(() {
                experienceValue = value!;
              });
            }
        ),
        SizedBox(
          height: 10,
        ),
        Text("What is your fitness goal?"),
        FitBuddyDropdownMenu(
            items: goalList,
            value: goalValue,
            onChange: (String? value) {
              setState(() {
                goalValue = value!;
              });
            }
        ),
        SizedBox(
          height: 10,
        ),
        Text("What is your fitness style?"),
        FitBuddyDropdownMenu(
            items: liftingStyleList,
            value: liftingStyleValue,
            onChange: (String? value) {
              setState(() {
                liftingStyleValue = value!;
              });
            }
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () {
                  _pageController.previousPage(
                      duration: Duration(milliseconds: 300),
                      curve: Curves.linear
                  );
                },
                child: Text("Previous")
            ),
            Row(
              children: [
                GestureDetector(
                  child: Text(
                    "skip",
                    style: TextStyle(
                        color: Colors.blue
                    ),
                  ),
                ),
                SizedBox(width: 20),
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
                ),

              ],
            ),
          ],
        ),
      ],
    );
  }

  nextPage() {
    if (userNameController.text.isEmpty || nameController.text.isEmpty) {
      updateErrorMessage("Name, username and age are required");
    } else {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300),
          curve: Curves.linear
      );
    }
  }

  submitData() async {

  }

  updateErrorMessage(String message) {
    setState(() {
      _errorMessage = message;
    });
  }

  errorMessage() {
    return Text(
      _errorMessage,
      style: TextStyle(
          color: Colors.red
      ),
    );
  }

}

