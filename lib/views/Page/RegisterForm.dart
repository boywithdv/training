import 'package:flutter/material.dart';
import 'package:training/components/textfield.dart';
import 'package:training/views/Page/RegisterFormless.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return RegisterPageless();
  }
}
