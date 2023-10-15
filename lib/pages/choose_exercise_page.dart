import 'package:fit_buddy/components/FitBuddyTextFormField.dart';
import 'package:fit_buddy/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseExercisePage extends StatefulWidget {
  static const String id = 'choose_exercise_page';

  const ChooseExercisePage({super.key});

  @override
  State<ChooseExercisePage> createState() => _ChooseExercisePageState();
}

class _ChooseExercisePageState extends State<ChooseExercisePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  Icon(Icons.arrow_back_ios_rounded),
                  Text("Choose Exercise"),
                ],
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search_rounded),
                ),
              ),
              Expanded(
                child: PageView(
                  children: [
                    favoritesView(),
                    allExercisesView(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  allExercisesView() {
    return Column(
      children: [
        exercise(),
        exercise(),
        exercise(),
      ],
    );
  }

  favoritesView() {
    return Column(
      children: [
          exercise(),
          exercise(),
          exercise(),
      ],
    );
  }

  exercise() {
    bool isFavorite = false;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Exercise Name"),
            IconButton(
              onPressed: () {
               // Todo
              },
              icon: isFavorite
                  ? Icon(Icons.star_rounded, color: FitBuddyColorConstants.lAccent)
                  : Icon(Icons.star_border_rounded, color: FitBuddyColorConstants.lAccent),
            ),
          ],
        ),
        Divider(thickness: 2, color: FitBuddyColorConstants.lAccent),
      ],
    );
  }

}

