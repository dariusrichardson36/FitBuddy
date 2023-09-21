import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_buddy/constants/route_constants.dart';
import 'package:fit_buddy/pages/auth_page.dart';
import 'package:fit_buddy/pages/complete_account_page.dart';
import 'package:fit_buddy/pages/home_page.dart';
import 'package:fit_buddy/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fit_buddy/services/firestore.dart';
import '../services/auth.dart';
import 'notifier.dart';

class FitBuddyRouter {
  //final notifier = ref.read(Auth().authStateChanges);
  GoRouter router = GoRouter(
      routes: [
        GoRoute(
          name: FitBuddyRouterConstants.homePage,
          path: '/',
          pageBuilder: (context, state) {
            return MaterialPage(
                child: HomePage(),
            );
          }
        ),
        GoRoute(
          name: FitBuddyRouterConstants.authPage,
          path: '/authentication',
          pageBuilder: (context, state) {
              return MaterialPage(
                child: AuthPage(),
              );
          }
        ),
        GoRoute(
          path: '/loading',
          pageBuilder: (context, state) {
            return MaterialPage(
              child: CircularProgressIndicator(),
            );
          }
        ),
        GoRoute(
          path: '/completeAccountInfo' ,
          pageBuilder: (context, state) {
            return MaterialPage(
                child: CompleteAccountInformation()
            );
          }
        )
      ],
    /*
    refreshListenable: GoRouterRefreshStream(Auth().authStateChanges),
    redirect: (context, state) async {
        User? user = Auth().currentUser;
        if (user == null) {
          return state.namedLocation(FitBuddyRouterConstants.authPage);
        }
        bool doesUserDataExist = await Firestore().doesUserDocumentExist(user.uid);
        if (!doesUserDataExist) {
          return '/completeAccountInfo';
        }
        return '/';
    }

     */
  );
}

