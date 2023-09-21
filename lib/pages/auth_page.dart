import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_buddy/pages/complete_account_page.dart';
import 'package:fit_buddy/pages/home_page.dart';
import 'package:fit_buddy/services/firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../services/auth.dart';
import '../components/my_textfield.dart';
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
      body: SafeArea(
        child: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            // logo
            Icon(
              Icons.local_fire_department_rounded,
              size: 100,
            ),
            SizedBox(height: 40),
            if (loginState) ... [
              loginEmailPw()
            ] else ...[
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
      ),
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
        children: [
          Text(
            'Sign in to FitBuddy',
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10),
          MyTextField(
            controller: emailController,
            hintText: 'email',
            obscureText: false,
          ),
          Text(
              "Forgot email?",
              textAlign: TextAlign.start,
          ),
          const SizedBox(height: 10),
          // password textfield
          MyTextField(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
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
          MyTextField(
            controller: emailController,
            hintText: 'email',
            obscureText: false,
          ),
          const SizedBox(height: 10),
          // password textfield
          MyTextField(
            controller: passwordController,
            hintText: 'Password',
            obscureText: true,
          ),
          const SizedBox(height: 10),
          // password textfield
          MyTextField(
            controller: confirmPasswordController,
            hintText: 'Confirm password',
            obscureText: true,
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
              onTap: () => Auth().signInWithGoogle(),
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