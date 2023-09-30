import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_buddy/pages/complete_account_page.dart';
import 'package:fit_buddy/pages/home_page.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth.dart';
import '../components/FitBuddyTextFormField.dart';
import '../components/FitBuddyThirdPartyBox.dart';


class AuthPage extends StatefulWidget {
  AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isNewUser = false; // This needs to be on false
  bool loginState = true; // The current state of the page

  void toggleLoginState() {
    setState(() {
      loginState = !loginState;
    });
  }



//
//  @override
//  void dispose() {
//    emailController.dispose();
//    passwordController.dispose();
    //super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // logo
                  SizedBox(
                    height: 100,
                    child: Image.asset('lib/images/logo.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "FitBuddy",
                    style: GoogleFonts.fugazOne(
                      fontSize: 26,
                      fontWeight: FontWeight.bold
                    ) ,
                  ),
                  SizedBox(height: 20),
                  if (loginState) ... [
                    loginEmailPw()
                  ] else
                    ...[
                      registerEmailPw()
                    ],
                  Spacer(),

                  Divider(
                    thickness: 1,
                  ),
                  SizedBox(height: 10),
                  otherLoginMethods(),
                  SizedBox(height: 75),
                ]
              ),
            )
        );
      })
    );
  }


  login() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      Auth().signInWithEmail(emailController.text, passwordController.text);
    } else {

    }
  }

  register() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty) {
      if (passwordController.text.trim() == confirmPasswordController.text.trim()) {
        Auth().registerWithEmail(emailController.text.trim(), passwordController.text.trim());
      } else {

      }
    } else {

    }
  }

  loginEmailPw() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Log in to your FitBuddy account',
          style: GoogleFonts.robotoFlex(
              fontWeight: FontWeight.w700,
              fontSize: 16
          ),
        ),
        SizedBox(height: 20),
        FitBuddyTextFormField(
          controller: emailController,
          hintText: 'Email',
          obscureText: false,
          validator: (value) {  },
        ),
        //const SizedBox(height: 20),
        FitBuddyTextFormField(
          controller: passwordController,
          hintText: 'Password',
          obscureText: true,
          validator: (value) {  },
          icon: Icon(Icons.visibility_off),
        ),
        SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: login,
            child: Text(
              "Log in",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text("No FitBuddy account yet? "),
            GestureDetector(
              onTap: toggleLoginState,
              child: Text(
                  "Register here",
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 16)
              ),
            ),
          ]
        ),
      ],
    );
  }

  registerEmailPw() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Register a account on FitBuddy',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16
          ),
        ),
        SizedBox(height: 20),
        FitBuddyTextFormField(
          controller: emailController,
          hintText: 'email',
          obscureText: false,
          validator: (value) {  },
        ),
        // password textfield
        FitBuddyTextFormField(
          controller: passwordController,
          hintText: 'Password',
          obscureText: true,
          validator: (value) {  },
        ),
        // password textfield
        FitBuddyTextFormField(
          controller: confirmPasswordController,
          hintText: 'Confirm password',
          obscureText: true,
          validator: (value) {  },
        ),
        SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: register,
            child: Text(
              "Register",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Row(
          children: [
            Text("Already have a FitBuddy account? "),
            GestureDetector(
              onTap: toggleLoginState,
              child: Text(
                  "Log in here",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16)
              ),
            )
          ],
        ),
      ],
    );
  }

  otherLoginMethods() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // google button
          FitBuddyThirdPartyBox(imagePath: 'lib/images/google.png',
            text: 'Continue with Google',
            onTap: () {
              Auth().signInWithGoogle();

            },
          ),
          SizedBox(height: 10),
          // apple button
          FitBuddyThirdPartyBox(
              imagePath: 'lib/images/apple.png',
              text: 'Continue with Apple',
              onTap: () => Auth().signInWithGoogle()
          )
        ],
      );
  }
}
