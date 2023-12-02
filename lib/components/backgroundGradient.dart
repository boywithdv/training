import 'package:flutter/material.dart';

class BackgroundGradient extends StatefulWidget {
  const BackgroundGradient({super.key});

  @override
  State<BackgroundGradient> createState() => _BackgroundGradientState();
}

class _BackgroundGradientState extends State<BackgroundGradient> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [
                Color.fromARGB(255, 0, 255, 174),
                Color.fromARGB(255, 29, 0, 107)
              ],
            ),
          ),
        ),
      ],
    );
  }
}
