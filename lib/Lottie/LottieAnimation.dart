import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieFiles extends StatefulWidget {
  final String lottie;
  const LottieFiles({super.key, required this.lottie});

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
      child: Container(
        child: Lottie.asset(widget.lottie, repeat: true),
      ),
    );
  }
}
