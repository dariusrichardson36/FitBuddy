import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/firestore.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late TextEditingController _controller;
  List<String> _searchResults = []; // This list will hold the search results

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final results = await Firestore().searchUser(_controller.text);
    setState(() {
      _searchResults = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(), // This will automatically navigate back and pop the screen off the stack
        title: TextField(
          controller: _controller,
          decoration: InputDecoration(
            hintText: 'Search',
          ),
          onSubmitted: (value) => _search(),
        ),
      ),
      body: ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          final user = _searchResults[index];
          return ListTile(
            title: GestureDetector(
              child: Text(user),
              onTap: () {

              }
            ),
          );
        },
      ),
    );
  }
}