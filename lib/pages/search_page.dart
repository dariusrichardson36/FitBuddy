

import 'package:flutter/cupertino.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});



  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Search Page"),
    );
  }
}