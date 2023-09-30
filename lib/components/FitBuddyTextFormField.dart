import 'package:flutter/material.dart';
import 'package:fit_buddy/constants/color_constants.dart';
import '../theme/theme_constants.dart';

class FitBuddyTextFormField extends StatefulWidget {
  final controller;
  final String hintText;
  final bool obscureText;
  final String? Function(dynamic value) validator;
  final Icon? icon;

  const FitBuddyTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.validator,
    this.icon,
  });

  @override
  State<FitBuddyTextFormField> createState() => _FitBuddyTextFormFieldState();
}

class _FitBuddyTextFormFieldState extends State<FitBuddyTextFormField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      validator: widget.validator,
      decoration: InputDecoration(

        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: FitBuddyColorConstants.lOnSecondary),

        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: FitBuddyColorConstants.lError),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(color: FitBuddyColorConstants.lOnSecondary),
        ),
        fillColor: fitBuddyLightTheme.colorScheme.secondary,
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        label: Text(
          widget.hintText,
          style: TextStyle(color: FitBuddyColorConstants.lOnSecondary),
        ),
        helperText: "",
        suffixIcon: widget.icon != null ? IconButton(
          icon: widget.icon!,
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ) : null,
      ),
    );
  }
}