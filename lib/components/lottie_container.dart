import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieContainer extends StatefulWidget {
  final double width;
  const LottieContainer({super.key, required this.width});

  @override
  State<LottieContainer> createState() => _LottieContainerState();
}

class _LottieContainerState extends State<LottieContainer>
    with TickerProviderStateMixin {
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
    double width = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        width: widget.width,
        child: Lottie.asset("assets/Lottie/lottie1.json", repeat: true),
      ),
    );
  }
}
