import 'package:flutter/material.dart';

class FitnessPng extends StatelessWidget {
  const FitnessPng({super.key, required this.png, this.width});
  final String png;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset(
        png,
      ),
    );
  }
}
