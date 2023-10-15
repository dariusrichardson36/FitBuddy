import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FitBuddyButton extends StatelessWidget {
  final String text;
  final onPressed;

  const FitBuddyButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}