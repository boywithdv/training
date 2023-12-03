import 'package:flutter/material.dart';
import 'package:training/Test/test.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/components/comp.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _BackGroundState();
}

class _BackGroundState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [BackgroundAnimation(), Test(), LPage()],
      ),
    );
  }
}
