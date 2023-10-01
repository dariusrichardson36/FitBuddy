import 'dart:ffi';

import 'package:fit_buddy/components/FitBuddyDropdownMenu.dart';
import 'package:fit_buddy/components/FitBuddySelectableButton.dart';
import 'package:fit_buddy/components/FitBuddyTextFormField.dart';
import 'package:fit_buddy/pages/complete_account_views/gender_selection.dart';
import 'package:fit_buddy/pages/home_page.dart';
import 'package:fit_buddy/services/auth.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../components/FitBuddyDateInputField.dart';

final experienceList = <String>["0-3 Months", "6 Months - 1 Year", "1 - 2 Years", "2 - 4 Years", "5 Years+"];
final goalList = <String>["Lose Weight", "Build Muscle", "Build Strength"];
final liftingStyleList = <String>["Calisthenics", "Powerlifting", "Bodybuilding", "Crossfit", "General Health"];


class CompleteAccountInformation extends StatefulWidget {
  const CompleteAccountInformation({super.key});

  @override
  State<StatefulWidget> createState() => _CompleteAccountInformationState();
}

class _CompleteAccountInformationState extends State<CompleteAccountInformation> {

  final _formKey = GlobalKey<FormState>();
  String experienceValue = "";
  String goalValue = "";
  String liftingStyleValue = "";
  bool isManSelected = false;
  bool isWomanSelected = false;
  final userNameController = TextEditingController();
  final usernameController = TextEditingController();
  final PageController _pageController = PageController();
  final firstDate = DateTime(DateTime.now().year - 100);
  final lastDate = DateTime.now();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.centerLeft,

                //constraints: const BoxConstraints(minWidth: 20, maxWidth: 30),
                onPressed: previousPage,
                icon: Icon(Icons.arrow_back_rounded),
                iconSize: 40,

              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: PageView(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  children: [
                    nameAndUsername(),
                    personalData(),
                    genderSelection(),
                    ageSelection(),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: nextPage,
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            ]
          ),
        ),
      ),
    );
  }

  Widget skipSetup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            print("object");
            submitAccountData();
            context.go('/homepage');
          },
          child: Text(
            "skip account setup",
            style: TextStyle(color: Colors.blue, fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget genderSelection() {
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
              isWomanSelected = false;
            });
          },
          isSelected: isManSelected,
        ),
        SizedBox(height: 20),
        FitBuddySelectableButton(
          text: "WOMAN",
          onTap: () {
            setState(() {
              isManSelected = false;
              isWomanSelected = true;
            });
          },
          isSelected: isWomanSelected,
        ),
        skipSetup(),
      ],
    );
  }

  Widget ageSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("My birthday is", style: TextStyle(fontSize: 20)),
        SizedBox(height: 20),
        FitBuddyDateInputField(),
        SizedBox(height: 10),
        skipSetup(),
      ],
    );
  }

  Widget nameAndUsername() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text("To create an account, we need to know your name and username"),
          SizedBox(
            height: 10,
          ),
          Text("No stress, you can change this later"),
          SizedBox(
            height: 10,
          ),
          FitBuddyTextFormField(
            controller: usernameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Display name is required';
              }
              return null;
            },
            hintText: 'Name',
            obscureText: false,
          ),
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
        ],
      ),
    );
  }

  Widget personalData() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Please complete these questions so we can match you to the right people."),
        Text("Don't worry, you can always do this later or change it."),
        SizedBox(
          height: 30,
        ),
        FitBuddyDropdownMenu(
          items: experienceList,
          value: experienceValue,
          labelText: "Choose your experience",
          onChange: (String? value) {
            setState(() {
              experienceValue = value!;
            });
          },
        ),
        SizedBox(
          height: 30,
        ),
        FitBuddyDropdownMenu(
          items: goalList,
          value: goalValue,
          labelText: "Choose your goal",
          onChange: (String? value) {
            setState(() {
              goalValue = value!;
            });
          },
        ),
        SizedBox(
          height: 30,
        ),
        FitBuddyDropdownMenu(
          items: liftingStyleList,
          value: liftingStyleValue,
          labelText: "Choose your lifting style",
          onChange: (String? value) {
            setState(() {
              liftingStyleValue = value!;
            });
          },
        ),
        SizedBox(
          height: 20,
        ),
        skipSetup(),
      ],
    );
  }

  Future<void> submitAccountData() async {
    try {
      await Firestore().createUser(
        Auth().currentUser!.uid,
        experienceValue.isEmpty ? null : experienceValue,
        goalValue.isEmpty ? null : goalValue,
        liftingStyleValue.isEmpty ? null : liftingStyleValue,
        userNameController.text,
        usernameController.text,
        isComplete(),
        selectedDate,
        getGender(),
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  bool isComplete() {
    return experienceValue.isNotEmpty &&
        goalValue.isNotEmpty &&
        liftingStyleValue.isNotEmpty &&
        getGender() != null &&
        selectedDate != null;
  }

  String? getGender() {
    if (isManSelected && !isWomanSelected) return "male";
    if (!isManSelected && isWomanSelected) return "female";
    return null; // if both are false, or both are true, return null.
  }

  void previousPage() {
    // if the page is the first page, log out
    if (_pageController.page == 0) {
      Auth().signOutUser();
    } else {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.linear,
      );
    }
  }

  void nextPage() {
    switch (_pageController.page?.toInt()) {
      case 0:
        if (_formKey.currentState!.validate()) {
          _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
        }
        break;
      case 1:
      case 2:
        _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.linear);
        break;
      case 3:
        submitAccountData();
        context.go('/homepage');
        break;
    }
  }
}
