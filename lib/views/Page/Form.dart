import 'package:flutter/material.dart';
import 'package:training/Lottie/LottieFiles.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/Organisms/textfieldState.dart';
import 'package:training/views/Page/RegisterForm.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _BackGroundState();
}

class _BackGroundState extends State<LoginForm> {
  //これをtrueにすることでアカウント作成フォームが作成される
  //これをfalseにすることでログインフォームとなる
  bool newAccountFlg = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundAnimation(),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: newAccountFlg ? null : LottieFiles(),
          ),
          AnimatedSwitcher(
              duration: Duration(milliseconds: 500),
              child: newAccountFlg ? RegisterForm() : LoginPage())
        ],
      ),
    );
  }
}
