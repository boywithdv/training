import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training/components/LottieAnimation.dart';
import 'package:training/controller/UserInfo.dart';

class LottieContainer extends StatefulWidget {
  const LottieContainer({super.key});

  @override
  State<LottieContainer> createState() => _LottieContainerState();
}

class _LottieContainerState extends State<LottieContainer> {
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
