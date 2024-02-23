import 'package:flutter/material.dart';

class TextFieldForLogin extends StatelessWidget {
  const TextFieldForLogin(
      {super.key,
      required this.prefixIcon,
      required this.hinttext,
      required this.pw,
      required this.textController,
      this.onChanged,
      this.suffixIcon});
  final String hinttext;
  final bool pw;
  final TextEditingController textController;
  final void Function(String)? onChanged;
  final Icon prefixIcon;
  final IconButton? suffixIcon;

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
            suffixIcon: suffixIcon,
            border: InputBorder.none,
            prefixIcon: prefixIcon,
            hintText: hinttext,
            hintStyle: TextStyle(color: Colors.white70),
          ),
        ),
      ),
    );
  }
}
