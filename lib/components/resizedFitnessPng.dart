import 'package:flutter/material.dart';
import 'package:training/components/ImageCircle.dart';

class ResizedFitnessPng extends StatelessWidget {
  const ResizedFitnessPng(
      {super.key,
      required this.png,
      required this.description,
      required this.onTap});

  final String png;
  final String description;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity * 0.1,
        height: 120,
        child: ImageCircle(
          png: png,
          description: description,
          fontsize: 11,
        ),
      ),
    );
  }
}
