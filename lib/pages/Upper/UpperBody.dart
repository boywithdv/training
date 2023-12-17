import 'package:flutter/material.dart';
import 'package:training/components/backgroundAnimationToFitness.dart';
import 'package:training/components/resizedFitnessPng.dart';
import 'package:training/models/models.dart';

class ToUpperBody extends StatefulWidget {
  const ToUpperBody({super.key});

  @override
  State<ToUpperBody> createState() => _ToUpperBodyState();
}

class _ToUpperBodyState extends State<ToUpperBody> {
  late String title;
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 40,
        ),
        ResizedFitnessPng(
          png: "assets/png/daikyoukin.png",
          description: '大胸筋',
          onTap: () {
            _navigateToSelectedFitness(
                '大胸筋', "assets/png/daikyoukin.png", pectoralisMajorMuscle);
          },
        ),
        const SizedBox(
          height: 15,
        ),
        ResizedFitnessPng(
          png: "assets/png/kata_sankakukin.PNG",
          description: '三角筋',
          onTap: () {
            _navigateToSelectedFitness(
                '三角筋', "assets/png/kata_sankakukin.PNG", pectoralisMajorMuscle);
          },
        ),
        const SizedBox(
          height: 15,
        ),
        ResizedFitnessPng(
          png: "assets/png/kouhaikin.PNG",
          description: '広背筋',
          onTap: () {
            _navigateToSelectedFitness(
                '広背筋', "assets/png/kouhaikin.PNG", pectoralisMajorMuscle);
          },
        ),
        const SizedBox(
          height: 15,
        ),
        ResizedFitnessPng(
          png: "assets/png/kubimoto.PNG",
          description: '僧帽筋',
          onTap: () {
            _navigateToSelectedFitness(
                '僧帽筋', "assets/png/kubimoto.PNG", pectoralisMajorMuscle);
          },
        ),
        const SizedBox(
          height: 15,
        ),
        ResizedFitnessPng(
          png: "assets/png/jouwansantoukin.PNG",
          description: '上腕三頭筋',
          onTap: () {
            _navigateToSelectedFitness('上腕三頭筋',
                "assets/png/jouwansantoukin.PNG", pectoralisMajorMuscle);
          },
        ),
        const SizedBox(
          height: 15,
        ),
        ResizedFitnessPng(
          png: "assets/png/gaihukusyakin.PNG",
          description: '腹斜筋',
          onTap: () {
            _navigateToSelectedFitness(
                '腹斜筋', "assets/png/gaihukusyakin.PNG", abs);
          },
        ),
        const SizedBox(
          height: 15,
        ),
        ResizedFitnessPng(
          png: "assets/png/hukkin.PNG",
          description: '腹筋',
          onTap: () {
            _navigateToSelectedFitness('腹筋', "assets/png/hukkin.PNG", abs);
          },
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
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
