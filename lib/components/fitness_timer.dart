import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:training/models/Data/app_colors.dart';

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
    return Center(
      child: CircularCountDownTimer(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 3,
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
        textStyle:
            TextStyle(fontSize: 50.0, color: AppColors.contentColorWhite),
        onComplete: onComplete,
      ),
    );
  }
}
