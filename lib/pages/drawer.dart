
import 'package:flutter/cupertino.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Text("Name@username"),
          Text("Profile"),
          Text("Settings"),

        ]
      )
    );
  }
}