import 'package:fit_buddy/components/FitBuddyTextFormField.dart';
import 'package:fit_buddy/constants/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChooseExerciseView extends StatefulWidget {
  static const String id = 'choose_exercise_page';

  const ChooseExerciseView({super.key});

  @override
  State<ChooseExerciseView> createState() => _ChooseExerciseViewState();
}

class _ChooseExerciseViewState extends State<ChooseExerciseView> with TickerProviderStateMixin  {
  late TabController _tabController;
  int _selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(height: 20),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back_ios_rounded, size: 30),
                  Expanded(
                    child: TabBar(
                      controller: _tabController,
                      indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 2.0, color: FitBuddyColorConstants.lAccent),
                        insets: EdgeInsets.symmetric(horizontal: 50.0),
                      ),
                      tabs: [
                        Text(
                          "All",
                          style: TextStyle(
                            fontWeight: _selectedTabIndex == 0 ? FontWeight.bold : FontWeight.normal,
                            color: FitBuddyColorConstants.lAccent,
                            fontSize: 16.0,
                          ),
                        ),
                        Text(
                          "Favorites",
                          style: TextStyle(
                            fontWeight: _selectedTabIndex == 1 ? FontWeight.bold : FontWeight.normal,
                            color: FitBuddyColorConstants.lAccent,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 30.0)
                ],
              ),
              SizedBox(height: 10.0),
              TextFormField(
                decoration: InputDecoration(
                  hintText: "Search",
                  prefixIcon: Padding(padding: EdgeInsets.only(right: 20) ,child: Icon(Icons.search_rounded, size: 30, color: FitBuddyColorConstants.lOnPrimary,)),
                  prefixIconConstraints: BoxConstraints(minWidth: 30, minHeight: 24),
                  border: InputBorder.none,
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
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

