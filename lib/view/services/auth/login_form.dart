import 'package:flutter/material.dart';
import 'package:training/components/lottie_files.dart';
import 'package:training/components/background_animation.dart';
import 'package:training/view/services/auth/login_page.dart';

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
      backgroundColor: Colors.black,
      body: Stack(
        children: [BackgroundAnimation(), LottieLogin(), LoginPage()],
      ),
    );
  }
}
