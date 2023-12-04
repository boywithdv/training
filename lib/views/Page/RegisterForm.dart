import 'package:flutter/material.dart';
import 'package:training/components/textfield.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _mailController = TextEditingController();
  final _pwController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print("Register Form Binding");
    return Stack(
      children: [
        Center(
          child: Container(
            height: 100,
            width: 400,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color.fromARGB(166, 1, 198, 109),
            ),
          ),
        ),
        Positioned(
          bottom: 456,
          left: 100,
          child: TextFieldForLogin(
            hinttext: "メールアドレス",
            pw: false,
            textController: _mailController,
            onChanged: (newValue) {},
          ),
        ),
        Positioned(
          bottom: 410,
          left: 100,
          child: TextFieldForLogin(
            hinttext: "パスワード",
            pw: true,
            textController: _pwController,
            onChanged: (newValue) {},
          ),
        ),
        Positioned(
          bottom: 476,
          left: 70,
          child: Icon(Icons.mail),
        ),
        Positioned(
          left: 70,
          bottom: 430,
          child: Icon(Icons.password),
        ),
        Center(
          child: Divider(
            indent: 22,
            endIndent: 22,
            thickness: 1,
            color: Colors.white70,
          ),
        )
      ],
    );
  }
}
