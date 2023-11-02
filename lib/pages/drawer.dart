import 'package:fit_buddy/constants/route_constants.dart';
import 'package:fit_buddy/theme/theme_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/auth.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 20, top: 10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Container(
                width: 75.0,
                height: 75.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://pbs.twimg.com/profile_images/1650839170653335552/WgtT2-ut_400x400.jpg'), // Replace with your image URL
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Zachary@Zac.Graham',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 35),
                  Text(
                    '215 Friends',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 50),
          Row(
            children: [
              const Icon(Icons.person, color: Colors.black, size: 35),
              const SizedBox(width: 15),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    'Profile',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.settings, color: Colors.black, size: 35),
              const SizedBox(width: 15),
              ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    'Settings',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.edit, color: Colors.black, size: 35),
              const SizedBox(width: 15),
              ElevatedButton(
                  onPressed: () {
                    context.goNamed(FitBuddyRouterConstants.createWorkoutPage);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    'Log Workout',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Icon(Icons.search, color: Colors.black, size: 35),
              const SizedBox(width: 15),
              ElevatedButton(
                  onPressed: () {
                    context.goNamed(FitBuddyRouterConstants.searchPage);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  child: const Text(
                    'Search',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  )),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () => Auth().signOutUser(),
                  icon: const Icon(Icons.logout_rounded)),
              IconButton(
                  onPressed: () => ThemeManager().toggleTheme(),
                  icon: const Icon(Icons.sunny))
            ],
          ),
        ]),
      ),
    );
  }
}
