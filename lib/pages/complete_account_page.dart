import 'package:fit_buddy/components/FitBuddyDropdownMenu.dart';
import 'package:fit_buddy/components/FitBuddySelectableButton.dart';
import 'package:fit_buddy/components/FitBuddyTextFormField.dart';
import 'package:fit_buddy/pages/complete_account_views/gender_selection.dart';
import 'package:fit_buddy/pages/home_page.dart';
import 'package:fit_buddy/services/auth.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
  String experienceValue = experienceList.first;
  String goalValue = goalList.first;
  String liftingStyleValue = liftingStyleList.first;
  final userNameController = TextEditingController();
  final usernameController = TextEditingController();
  final PageController _pageController = PageController();
  final firstDate = DateTime(DateTime.now().year - 100);
  final lastDate = DateTime.now();
  late DateTime selectedDate;

  List<GlobalKey<FormState>> formKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    ageSelection(),
                    nameAndUsername(),
                    personalData(),

                    GenderSelection(),

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

  Widget ageSelection() {
    return Column(
      children: [
        Text("You need to be at least X years of age to use the FitBuddy App"),
        InputDatePickerFormField(
          onDateSubmitted: (value) {
            selectedDate = value;
          },
          onDateSaved:(value) {
            selectedDate = value;
          },
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


          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState?.save();
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
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: () {
                submitReqOnly();
                context.go('/homepage');
              },
              child: Text(
                "skip account setup",
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> submitAllData() async {
    try {
      await Firestore().createUser(
        Auth().currentUser!.uid,
        experienceValue,
        goalValue,
        liftingStyleValue,
        userNameController.text,
        usernameController.text,
        true,
        selectedDate
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  Future<void> submitReqOnly() async {
    try {
      await Firestore().createUser(
          Auth().currentUser!.uid,
          null,
          null,
          null,
          userNameController.text,
          usernameController.text,
          false,
          selectedDate
      );
    } catch(e) {
      // todo
    }
    //context.go('/homepage');

  }

  void previousPage() {
    // if the page is the first page, log out
    if (_pageController.page == 0) {
      Auth().signOutUser();
    }
    _pageController.previousPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }

  void nextPage() {
    _pageController.nextPage(
      duration: Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }
}
