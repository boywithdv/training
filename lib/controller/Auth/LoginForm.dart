import 'package:flutter/material.dart';
import 'package:training/Lottie/LottieFiles.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/controller/Auth/LoginPage.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _BackGroundState();
}

class _BackGroundState extends State<LoginForm> {
  //これをtrueにすることでアカウント作成フォームが作成される
  //これをfalseにすることでログインフォームとなる
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [BackgroundAnimation(), LottieFiles(), LoginPage()],
      ),
    );
  }
}
