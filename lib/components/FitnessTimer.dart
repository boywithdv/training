import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';

class FitNessT extends StatelessWidget {
  const FitNessT(
      {super.key,
      this.child,
      required this.controller,
      required this.onStart,
      required this.onComplete,
      required this.timer,
      required this.autoStart});
  final CountDownController controller;
  final Function() onStart;
  final Function() onComplete;
  final int timer;
  final bool autoStart;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CircularCountDownTimer(
      width: MediaQuery.of(context).size.width / 2,
      height: MediaQuery.of(context).size.height / 2,
      duration: timer,
      fillColor: const Color.fromARGB(255, 7, 255, 40),
      ringColor: Colors.transparent,
      controller: controller,
      backgroundColor: Colors.transparent,
      strokeWidth: 12.0,
      strokeCap: StrokeCap.round,
      isTimerTextShown: true,
      isReverse: false,
      onStart: onStart,
      autoStart: autoStart,
      textStyle: TextStyle(fontSize: 50.0, color: Colors.white),
      onComplete: onComplete,
    );
  }
}
