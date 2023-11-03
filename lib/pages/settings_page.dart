import 'package:fit_buddy/constants/color_constants.dart';
import 'package:fit_buddy/constants/route_constants.dart';
import 'package:fit_buddy/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/auth.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10,20,10,10),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => context.goNamed(FitBuddyRouterConstants.homePage),
                    icon: Icon(Icons.arrow_back,
                    color: FitBuddyColorConstants.lOnPrimary)
                  ),
                ],
              ),
              const Center(
                child: Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 25
                  )
                ),
              )
            ],
          ),
        )
      )
    );
  }
}
