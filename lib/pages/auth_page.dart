import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_buddy/pages/test.dart';
import 'package:flutter/material.dart';

import '../auth.dart';
import '../components/my_textfield.dart';
import '../components/square_tile.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isNewUser = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return TestPage();
          } else {
            return LoginPage(context);
          }
        },
      ),
    );
  }

  LoginPage(context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),

              // logo
              const Icon(
                Icons.local_fire_department_rounded,
                size: 100,
              ),

              const SizedBox(height: 50),
              Text(
                'Login to FitBuddy',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

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
                      isNewUser = userCredential.additionalUserInfo!.isNewUser;
                      Navigator.pop(context);
                      showDialog(context: context, builder: (context) {
                        return Center(
                          child: Text("This user is new = $isNewUser"),
                        );
                      });
                    },
                    child: Text("Register"),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              // google + apple sign in buttons
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // google button
                  SquareTile(imagePath: 'lib/images/google.png',
                    text: 'Continue with Google',
                    onTap: () => Auth().signInWithGoogle(),
                  ),

                  const SizedBox(width: 25),

                  // apple button
                  SquareTile(
                      imagePath: 'lib/images/apple.png',
                      text: 'Continue with Apple',
                      onTap: () => Auth().signInWithGoogle()
                  )
                ],
              ),

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
    );
  }
}