import 'package:flutter/material.dart';

class TextFieldForLogin extends StatelessWidget {
  const TextFieldForLogin(
      {super.key,
      required this.icon,
      required this.hinttext,
      required this.pw,
      required this.textController,
      required this.onChanged});
  final String hinttext;
  final bool pw;
  final TextEditingController textController;
  final void Function(String) onChanged;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      padding: EdgeInsets.all(10),
      width: 300,
      child: TextField(
        onChanged: onChanged,
        obscureText: pw,
        controller: textController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: icon,
          hintText: hinttext,
          hintStyle: TextStyle(color: Colors.white70),
        ),
      ),
    ));
  }
}
