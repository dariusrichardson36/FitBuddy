import 'package:fit_buddy/constants/color_constants.dart';
import 'package:fit_buddy/models/FitBuddyExerciseModel.dart';
import 'package:fit_buddy/services/firestore/firestore_service.dart';
import 'package:flutter/material.dart';

class ChooseExerciseView extends StatefulWidget {
  static const String id = 'choose_exercise_page';
  final VoidCallback onButtonPressed;

  const ChooseExerciseView({
    super.key,
    required this.onButtonPressed
  });

  @override
  State<ChooseExerciseView> createState() => _ChooseExerciseViewState();
}

class _ChooseExerciseViewState extends State<ChooseExerciseView> with TickerProviderStateMixin  {
  late TabController _tabController;
  int _selectedTabIndex = 0;
  late Stream _favoriteExercises;
  late Future _allExercises;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
    _favoriteExercises = FirestoreService.firestoreService().postService.getFavoriteExercises();
    _allExercises = FirestoreService.firestoreService().postService.getAllExercises();
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
                  IconButton(icon: Icon(Icons.arrow_back_ios_rounded, size: 30), onPressed: widget.onButtonPressed),
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
                    allExercisesView(),
                    favoritesView(),
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
    return FutureBuilder(future: _allExercises, builder: (context, snapshot) {
      return snapshot.hasData ? ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return exercise(snapshot.data[index], false);
        },
      ) : Center(child: CircularProgressIndicator());
    });
  }

  favoritesView() {
    return StreamBuilder(stream: _favoriteExercises, builder: (context, snapshot) {
      return snapshot.hasData ? ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (context, index) {
          return exercise(snapshot.data[index], true);
        },
      ) : Center(child: CircularProgressIndicator());
    });
  }

  exercise(Exercise exercise, bool isFavorite) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(exercise.name),
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

