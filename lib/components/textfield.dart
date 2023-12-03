import 'package:flutter/material.dart';

class TextFieldForLogin extends StatelessWidget {
  const TextFieldForLogin({super.key, required this.text, required this.pw});
  final String text;
  final bool pw;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: EdgeInsets.all(10),
      width: 300,
      child: TextField(
        obscureText: pw,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,
            hintStyle: TextStyle(color: Colors.grey.shade700)),
      ),
    ));
  }
}
