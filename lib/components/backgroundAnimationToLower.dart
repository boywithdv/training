import 'package:flutter/material.dart';
import 'package:animated_background/animated_background.dart';
import 'package:training/view/pages/Lower/LowerBody.dart';

class BackgroundAnimationToLower extends StatefulWidget {
  const BackgroundAnimationToLower({super.key});

  @override
  State<BackgroundAnimationToLower> createState() =>
      _BackgroundAnimationState();
}

class _BackgroundAnimationState extends State<BackgroundAnimationToLower>
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
            child: ToLowerBody()));
  }
}
