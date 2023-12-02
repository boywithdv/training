import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieTile extends StatelessWidget {
  const LottieTile(
      {super.key, required this.animationController, required this.assets});
  final AnimationController animationController;
  final String assets;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Lottie.asset(assets, controller: animationController),
    );
  }
}
