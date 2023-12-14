import 'package:flutter/material.dart';

class TextColorWhite extends StatelessWidget {
  final String text;
  const TextColorWhite({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: Colors.white),
    );
  }
}
