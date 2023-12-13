import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:training/components/Circle.dart';

class LottieFiles extends StatefulWidget {
  const LottieFiles({super.key});

  @override
  State<LottieFiles> createState() => _MyAppState();
}

class _MyAppState extends State<LottieFiles> with TickerProviderStateMixin {
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
