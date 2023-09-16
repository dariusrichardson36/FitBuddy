import 'package:flutter/material.dart';

class SquareTile extends StatelessWidget {
  final String imagePath;
  final String text;
  final Function()? onTap;
  const SquareTile({
    super.key,
    required this.imagePath,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child:Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(16),
            color: Colors.grey[200],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset(
                alignment: Alignment.centerLeft,
                imagePath,
                height: 40,
                width: 50,
              ),
              Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(
                width: 50,
              )
            ],
          )
      ),
    );
  }
}