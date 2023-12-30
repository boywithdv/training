import 'package:flutter/material.dart';
import 'package:training/components/fitnessPng.dart';

class ImageCircle extends StatelessWidget {
  const ImageCircle(
      {super.key,
      required this.png,
      required this.description,
      required this.fontsize});
  final String png;
  final String description;
  final double fontsize;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Color.fromARGB(168, 85, 102, 251),
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 20,
            ),
            FitnessPng(
              png: png,
            ),
            Container(
              height: 30,
              width: 170,
              child: Text(
                description,
                style: TextStyle(color: Colors.white70, fontSize: fontsize),
              ),
            ),
          ],
        ));
  }
}
