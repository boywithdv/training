import 'package:flutter/material.dart';
import 'package:training/Test/test.dart';
import 'package:training/components/Circle.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/components/backgroundGradient.dart';

class BackGround extends StatefulWidget {
  const BackGround({super.key});

  @override
  State<BackGround> createState() => _BackGroundState();
}

class _BackGroundState extends State<BackGround> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [BackgroundAnimation(), Test()],
      ),
    );
  }
}
