import 'package:flutter/material.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key, required this.onChanged});
  final void Function() onChanged;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
            onPressed: onChanged,
            child: Text(
              "Create Account",
              style: TextStyle(color: Color.fromRGBO(49, 39, 79, .6)),
            )));
  }
}
