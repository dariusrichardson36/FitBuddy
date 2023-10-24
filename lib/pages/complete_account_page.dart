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
  final nameController = TextEditingController();
  final PageController _pageController = PageController();
  final firstDate = DateTime(DateTime.now().year - 100);
  final lastDate = DateTime.now();
  DateTime? _selectedDate;

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
            submitAccountData();
            context.go('/');
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
        SizedBox(height: 20),
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
        FitBuddyDateInputField(
          onDateSelected: (selectedDate) {
            _selectedDate = selectedDate;
          },
        ),
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
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty ) {
                return 'Name is required';
              } else if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
                return 'Name can only contain alphanumeric characters';
              } else if (value.length < 3) {
                return 'Name must be at least 3 characters long';
              } else if (value.length > 20) {
                return 'Name must be less than 20 characters long';
              }
              return null;
            },
            hintText: 'Name',
            isPassword: false,
          ),
          FitBuddyTextFormField(
            controller: userNameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Username is required';
              } else if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(value)) {
                return 'Username can only contain alphanumeric characters and underscores';
              } else if (value.length < 3) {
                return 'Username must be at least 3 characters long';
              } else if (value.length > 20) {
                return 'Username must be less than 20 characters long';
              }
              return null;
            },
            hintText: 'Username',
            isPassword: false,
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
      await FireStore.FireStore().createUser(
        Auth().currentUser!.uid,
        experienceValue.isEmpty ? null : experienceValue,
        goalValue.isEmpty ? null : goalValue,
        liftingStyleValue.isEmpty ? null : liftingStyleValue,
        userNameController.text.trim(),
        nameController.text.trim(),
        isComplete(),
        _selectedDate,
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
        _selectedDate != null;
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
        context.go('/');
        break;
    }
  }
}
