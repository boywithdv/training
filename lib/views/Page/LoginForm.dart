import 'package:flutter/material.dart';
import 'package:training/Lottie/LottieFiles.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/Organisms/LPage.dart';
import 'package:training/components/textfieldState.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _BackGroundState();
}

class _BackGroundState extends State<LoginForm> {
  //これをtrueにすることでcontainerに変更される
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
              child: newAccountFlg
                  ? Center(
                      child: Container(
                        height: 800,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color.fromARGB(166, 1, 198, 109),
                        ),
                      ),
                    )
                  : LoginPage())
        ],
      ),
    );
  }
}
