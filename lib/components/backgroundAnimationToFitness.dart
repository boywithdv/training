import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:training/components/trainingMenu.dart';
import 'package:training/models/models.dart';

class BackgroundAnimationToFitness extends StatefulWidget {
  final String title;
  final String fitnessPng;
  final List<FitnessModel> lottieName;
  const BackgroundAnimationToFitness({
    super.key,
    required this.title,
    required this.fitnessPng,
    required this.lottieName,
  });

  @override
  State<BackgroundAnimationToFitness> createState() =>
      _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimationToFitness>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(Icons.arrow_circle_left_outlined),
            color: Colors.white,
          ),
          title: Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.black,
        body: AnimatedBackground(
            behaviour: RandomParticleBehaviour(
              options: const ParticleOptions(
                spawnMaxRadius: 50,
                spawnMinSpeed: 10.00,
                particleCount: 68,
                spawnMaxSpeed: 50,
                minOpacity: 0.3,
                spawnOpacity: 0.4,
                baseColor: Color.fromARGB(119, 0, 34, 23),
              ),
            ),
            vsync: this,
            child: TrainingMenu(
              title: widget.title,
              png: widget.fitnessPng,
              lottieName: widget.lottieName,
            )));
  }
}
