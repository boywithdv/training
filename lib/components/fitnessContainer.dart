import 'package:flutter/material.dart';
import 'package:training/components/ImageCircle.dart';
import 'package:training/components/LottieAnimation.dart';
import 'package:training/models/Data/app_colors.dart';
import 'package:training/models/models.dart';

class FitnessContainer extends StatefulWidget {
  final String muscleDescription;
  final String musclePng;
  final List<FitnessModel> muscleLottie;
  final int index;
  const FitnessContainer(
      {super.key,
      required this.muscleDescription,
      required this.musclePng,
      required this.muscleLottie,
      required this.index});

  @override
  State<FitnessContainer> createState() => _FitnessContainerState();
}

class _FitnessContainerState extends State<FitnessContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 380,
          height: 90,
          child: ImageCircle(
            png: widget.musclePng,
            description: widget.muscleDescription,
            fontsize: 14,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: 390,
          height: 290,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: AppColors.pageBackground,
          ),
          child: LottieFiles(
              lottie: widget.muscleLottie[widget.index].fitnessLottieName),
        ),
      ],
    );
  }
}
