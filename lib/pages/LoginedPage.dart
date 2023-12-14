import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:training/components/app_description.dart';
import 'package:training/components/backgroundAnimation.dart';

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
    return ImageFiltered(
      imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: BackgroundAnimation(),
    );
  }
}
