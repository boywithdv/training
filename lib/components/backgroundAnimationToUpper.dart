import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:training/pages/Upper/UpperBody.dart';

class BackgroundAnimationToUpper extends StatefulWidget {
  const BackgroundAnimationToUpper({super.key});

  @override
  State<BackgroundAnimationToUpper> createState() =>
      _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimationToUpper>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            child: ToUpperBody()));
  }
}
