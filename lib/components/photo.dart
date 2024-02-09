import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training/components/LottieAnimation.dart';
import 'package:training/controller/UserInfo.dart';

class Photo extends StatefulWidget {
  final double width;
  const Photo({super.key, required this.width});

  @override
  State<Photo> createState() => _PhotoState();
}

class _PhotoState extends State<Photo> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: userId != null
            ? LottieFiles(
                lottie: 'assets/Lottie/lottie3.json',
              )
            : LottieFiles(
                lottie: 'assets/Lottie/lottie2.json',
              ));
  }
}
