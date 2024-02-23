import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:training/components/circle.dart';

class LottieLogin extends StatefulWidget {
  const LottieLogin({super.key});

  @override
  State<LottieLogin> createState() => _MyAppState();
}

class _MyAppState extends State<LottieLogin> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(children: [
        Circle(),
        Center(
          child: Container(
            child: Lottie.asset('assets/Lottie/lottie2.json', repeat: true),
          ),
        )
      ]),
    );
  }
}
