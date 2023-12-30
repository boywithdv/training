import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/pages/app_description.dart';

class LoginedPage extends StatefulWidget {
  const LoginedPage({super.key});

  @override
  State<LoginedPage> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<LoginedPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(children: [BackgroundAnimation(), AppDescription()]),
    );
  }
}

class BGAnimationImageFillter extends StatelessWidget {
  const BGAnimationImageFillter({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundAnimation();
  }
}
