import 'package:fit_buddy/components/FitBuddyDropdownMenu.dart';
import 'package:fit_buddy/components/FitBuddyTextFormField.dart';
import 'package:fit_buddy/pages/home_page.dart';
import 'package:fit_buddy/services/auth.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final experienceList = <String>["Choose your experience", "0-3 Months", "6 Months - 1 Year", "1 - 2 Years", "2 - 4 Years", "5 Years+"];
final goalList = <String>["Choose your goal", "Lose Weight", "Build Muscle", "Build Strength"];
final liftingStyleList = <String>["Choose your lifting style", "Calisthenics", "Powerlifting", "Bodybuilding", "Crossfit", "General Health"];


class CompleteAccountInformation extends StatefulWidget {
  const CompleteAccountInformation({super.key});

  @override
  State<StatefulWidget> createState() => _CompleteAccountInformationState();
}

class _CompleteAccountInformationState extends State<CompleteAccountInformation> {

  final _formKey = GlobalKey<FormState>();
  String experienceValue = experienceList.first;
  String goalValue = goalList.first;
  String liftingStyleValue = liftingStyleList.first;
  final userNameController = TextEditingController();
  final nameController = TextEditingController();
  final PageController _pageController = PageController();
  final firstDate = DateTime(DateTime.now().year - 100);
  final lastDate = DateTime.now();
  DateTime? selectedDate;

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
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: [
                    requiredInformation(),
                    personalData(),
                  ],
                ),
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {Auth().signOutUser();},
                    child: Text(
                      "Return to login screen",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ]
          ),
        ),
      ),
    );
  }

  Widget requiredInformation() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("Please provide your name, username, and date of birth"),
          Text("Don't worry, you can change your name and username at any given time!"),
          SizedBox(
            height: 10,
          ),
          FitBuddyTextFormField(
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Display name is required';
              }
              return null;
            },
            hintText: 'Display name',
            obscureText: false,
          ),
          SizedBox(height: 10),
          FitBuddyTextFormField(
            controller: userNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Username is required';
              }
              return null;
            },
            hintText: 'Username',
            obscureText: false,
          ),
          SizedBox(
            height: 10,
          ),
          Text("You need to be at least X years of age to use the FitBuddy App"),
          InputDatePickerFormField(
            acceptEmptyDate: false,
            errorFormatText: "Invalid date format",
            errorInvalidText: "Invalid date",
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
                  if (_formKey.currentState!.validate()) {
                    nextPage();
                  }
                },
                child: Text("Next"),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget personalData() {
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
          },
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
          },
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
          },
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
                  curve: Curves.linear,
                );
              },
              child: Text("Previous"),
            ),
            Row(
              children: [
                GestureDetector(
                  child: Text(
                    "skip",
                    style: TextStyle(color: Colors.blue),
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
                      liftingStyleValue,
                    );
                    context.go('/homepage');
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }
}
