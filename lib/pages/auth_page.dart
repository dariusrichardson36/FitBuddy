import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_buddy/pages/complete_account_page.dart';
import 'package:fit_buddy/pages/home_page.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/auth.dart';
import '../components/FitBuddyTextFormField.dart';
import '../components/square_tile.dart';


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
  String _currentErrorMessage = "";

  void toggleLoginState() {
    setState(() {
      loginState = !loginState;
      _currentErrorMessage = "";
    });
  }

  void setErrorMessage(message) {
    setState(() {
      _currentErrorMessage = message;
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
      body: StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return SafeArea(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 20),
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
                errorMessage(),
                //Spacer(),
                Divider(
                  thickness: 2,
                ),
                otherLoginMethods(),
                SizedBox(height: 60),
              ]
          )
        );
      })
    );
  }


  login() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      Auth().signInWithEmail(emailController.text, passwordController.text);
    } else {
      setErrorMessage("Please fill in email and password");
    }
  }

  register() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty) {
      if (passwordController.text.trim() == confirmPasswordController.text.trim()) {
        Auth().registerWithEmail(emailController.text.trim(), passwordController.text.trim());
      } else {
        setErrorMessage("Both passwords need to be the same");
      }
    } else {
      setErrorMessage("Please fill in all the required fields");
    }
  }

  loginEmailPw() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Log in to your FitBuddy account',
            style: GoogleFonts.robotoFlex(
                fontWeight: FontWeight.w700,
                fontSize: 16
            ),
          ),
          SizedBox(height: 10),
          FitBuddyTextFormField(
            controller: emailController,
            hintText: 'email',
            obscureText: false,
            validator: (value) {  },
          ),
          Text(
              "Forgot email?",
              textAlign: TextAlign.start,
          ),
          const SizedBox(height: 10),
          // password textfield
          FitBuddyTextFormField(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
            validator: (value) {  },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: login,
                child: Text("Sign In"),
              ),
              GestureDetector(
                onTap: toggleLoginState,
                child: Text(
                    "Register here",
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 16)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  registerEmailPw() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Column(
        children: [
          Text(
            'Register an account on FitBuddy',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          FitBuddyTextFormField(
            controller: emailController,
            hintText: 'email',
            obscureText: false,
            validator: (value) {  },
          ),
          const SizedBox(height: 10),
          // password textfield
          FitBuddyTextFormField(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
            validator: (value) {  },
          ),
          const SizedBox(height: 10),
          // password textfield
          FitBuddyTextFormField(
            controller: confirmPasswordController,
            hintText: 'Confirm password',
            obscureText: true,
            validator: (value) {  },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: register,
                child: Text("Register"),
              ),
              GestureDetector(
                onTap: toggleLoginState,
                child: Text(
                    "Sign in here",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16)
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  otherLoginMethods() {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // google button
            SquareTile(imagePath: 'lib/images/google.png',
              text: 'Continue with Google',
              onTap: () {
                Auth().signInWithGoogle();

              },
            ),
            SizedBox(height: 15),
            // apple button
            SquareTile(
                imagePath: 'lib/images/apple.png',
                text: 'Continue with Apple',
                onTap: () => Auth().signInWithGoogle()
            )
          ],
        ),
      );
  }

  errorMessage() {
    return Text(
      _currentErrorMessage,
      style: TextStyle(
        color: Colors.red
      ),
    );
  }
}