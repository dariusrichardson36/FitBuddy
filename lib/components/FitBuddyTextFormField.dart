import 'package:flutter/material.dart';
import 'package:fit_buddy/constants/color_constants.dart';
import '../theme/theme_constants.dart';

class FitBuddyTextFormField extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final String? Function(dynamic value) validator;

  const FitBuddyTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: FitBuddyColorConstants.lOnSecondary),

        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: FitBuddyColorConstants.lOnSecondary),
        ),
        fillColor: fitBuddyLightTheme.colorScheme.secondary,
        filled: true,
        hintStyle: TextStyle(color: FitBuddyColorConstants.lOnSecondary),
        hintText: hintText
      ),
    );
  }
}