import 'package:flutter/material.dart';
import 'package:training/components/backgroundAnimationToFitness.dart';
import 'package:training/components/resizedFitnessPng.dart';
import 'package:training/models/models.dart';

class ToLowerBody extends StatefulWidget {
  const ToLowerBody({super.key});

  @override
  State<ToLowerBody> createState() => _ToLowerBodyState();
}

class _ToLowerBodyState extends State<ToLowerBody> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(
        children: [
          SizedBox(
            height: 40,
          ),
          ResizedFitnessPng(
            png: "assets/png/hamusutoring.PNG",
            description: 'ハムストリングス',
            onTap: () {
              print("ハムストリング");
              _navigateToSelectedFitness(
                  'ハムストリング', 'assets/png/hamusutoring.PNG', thigh);
            },
          ),
          SizedBox(
            height: 15,
          ),
          ResizedFitnessPng(
            png: "assets/png/hihukukin.PNG",
            description: '腓腹筋',
            onTap: () {
              _navigateToSelectedFitness(
                  "腓腹筋", "assets/png/hihukukin.PNG", thigh);
            },
          ),
          SizedBox(
            height: 15,
          ),
          ResizedFitnessPng(
            png: "assets/png/oshiri.PNG",
            description: '大臀筋',
            onTap: () {
              _navigateToSelectedFitness(
                  '大臀筋', 'assets/png/oshiri.PNG', buttocks);
            },
          ),
          SizedBox(
            height: 15,
          ),
          ResizedFitnessPng(
            png: "assets/png/daitaisitoukin.PNG",
            description: '大腿四頭筋',
            onTap: () {
              print("大腿四頭筋");
              _navigateToSelectedFitness(
                  '大腿四頭筋', 'assets/png/daitaisitoukin.PNG', thigh);
            },
          ),
        ],
      )
    ]);
  }

  void _navigateToSelectedFitness(
      String muscleName, String musclePng, List<FitnessModel> lottie) {
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        opaque: true,
        pageBuilder: (BuildContext context, _, __) {
          print(lottie.length);
          return BackgroundAnimationToFitness(
            title: muscleName,
            fitnessPng: musclePng,
            lottieName: lottie,
          );
        },
      ),
    );
  }
}
