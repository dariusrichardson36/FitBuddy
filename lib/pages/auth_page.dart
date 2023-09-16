import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_buddy/pages/complete_account_page.dart';
import 'package:fit_buddy/pages/test.dart';
import 'package:flutter/material.dart';

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

  void toggleLoginState() {
    setState(() {
      loginState = !loginState;
    });
  }


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    //super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          print("isNewUser = " + isNewUser.toString());
          if (!snapshot.hasData) {
            return authPage();
          } else if (isNewUser) {
            return CompleteAccountInformation();
          }
          else {
            return TestPage();
          }
        },
      ),
    );
  }

  authPage() {
    return SafeArea(
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

          //Spacer(),
          Divider(
            thickness: 2,
          ),
          otherLoginMethods(),
          SizedBox(height: 60),
        ]
      )
    );
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
                  onPressed: toggleLoginState,
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
                onPressed: () => {},
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

  LoginPage(context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                const SizedBox(height: 50),


                const SizedBox(height: 25),

                // username textfield
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
                const SizedBox(height: 25),

                // sign in button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      // todo: Add error messages
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                        UserCredential userCredential = await Auth().signInWithEmail(emailController.text, passwordController.text);
                        isNewUser = userCredential.additionalUserInfo!.isNewUser;
                        Navigator.pop(context);
                        showDialog(context: context, builder: (context) {
                          return Center(
                            child: Text("This user is new = $isNewUser"),
                          );
                        });
                      },
                      child: Text("Sign In"),
                    ),
                    GestureDetector(
                      // todo: Add error messages
                      onTap: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            });
                        UserCredential userCredential = await Auth().registerWithEmail(emailController.text, passwordController.text);
                        isNewUser = true;
                        Navigator.pop(context);
                      },
                      child: Text("Register"),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                // google + apple sign in buttons


                const SizedBox(height: 50),

                // not a member? register now
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Not a member?',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}