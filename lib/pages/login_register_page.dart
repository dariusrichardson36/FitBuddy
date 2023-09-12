import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_buddy/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/my_textfield.dart';
import '../components/square_tile.dart';


class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  

  @override
  Widget build(BuildContext context) {
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
                  await Auth().signInWithEmail(emailController.text, passwordController.text);
                  Navigator.pop(context);
                  },
                child: Text("Sign In"),
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
                  const Text(
                    'Register now',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}