import 'package:flutter/material.dart';
import 'package:training/Lottie/LottieFiles.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/components/comp.dart';
import 'package:training/components/textfieldState.dart';

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
        children: [BackgroundAnimation(), LottieFiles(), LoginPage()],
      ),
    );
  }
}
