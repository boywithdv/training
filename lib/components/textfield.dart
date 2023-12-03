import 'package:flutter/material.dart';

class TextFieldForLogin extends StatelessWidget {
  const TextFieldForLogin(
      {super.key,
      required this.text,
      required this.pw,
      required this.textController,
      required this.onChanged});
  final String text;
  final bool pw;
  final TextEditingController textController;
  final void Function(String) onChanged;

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
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: text,
            hintStyle: TextStyle(color: Colors.grey.shade700)),
      ),
    ));
  }
}
