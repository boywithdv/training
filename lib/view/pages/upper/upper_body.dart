import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:training/components/background_animation_to_fitness.dart';
import 'package:training/components/resized_fitness_png.dart';
import 'package:training/controller/admob.dart';
import 'package:training/models/models.dart';

class ToUpperBody extends StatefulWidget {
  const ToUpperBody({super.key});

  @override
  State<ToUpperBody> createState() => _ToUpperBodyState();
}

class _ToUpperBodyState extends State<ToUpperBody> {
  late String title;
  final AdMob _adMob = AdMob();
  @override
  void initState() {
    super.initState();
    _adMob.load();
  }

  @override
  void dispose() {
    super.dispose();
    _adMob.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        FutureBuilder(
          future: AdSize.getAnchoredAdaptiveBannerAdSize(
            Orientation.portrait,
            MediaQuery.of(context).size.width.truncate(),
          ),
          builder: (BuildContext context,
              AsyncSnapshot<AnchoredAdaptiveBannerAdSize?> snapshot) {
            if (snapshot.hasData) {
              return SizedBox(
                width: double.infinity,
                child: _adMob.getAdBanner(),
              );
            } else {
              return Container(
                height: _adMob.getAdBannerHeight(),
                color: Colors.white,
              );
            }
          },
        ),
        const SizedBox(
          height: 40,
        ),
        ResizedFitnessPng(
          png: "assets/img/daikyoukin.png",
          description: '大胸筋',
          onTap: () {
            _navigateToSelectedFitness(
                '大胸筋', "assets/img/daikyoukin.png", pectoralisMajorMuscle);
          },
        ),
        const SizedBox(
          height: 15,
        ),
        ResizedFitnessPng(
          png: "assets/img/kata_sankakukin.PNG",
          description: '三角筋',
          onTap: () {
            _navigateToSelectedFitness(
                '三角筋', "assets/img/kata_sankakukin.PNG", deltoid);
          },
        ),
        /*
        const SizedBox(
          height: 15,
        ),
        ResizedFitnessPng(
          png: "assets/img/kouhaikin.PNG",
          description: '広背筋',
          onTap: () {
            _navigateToSelectedFitness(
                '広背筋', "assets/img/kouhaikin.PNG", pectoralisMajorMuscle);
          },
        ),
        const SizedBox(
          height: 15,
        ),
        ResizedFitnessPng(
          png: "assets/img/kubimoto.PNG",
          description: '僧帽筋',
          onTap: () {
            _navigateToSelectedFitness(
                '僧帽筋', "assets/img/kubimoto.PNG", pectoralisMajorMuscle);
          },
        ),
        const SizedBox(
          height: 15,
        ),
        ResizedFitnessPng(
          png: "assets/img/jouwansantoukin.PNG",
          description: '上腕三頭筋',
          onTap: () {
            _navigateToSelectedFitness('上腕三頭筋',
                "assets/img/jouwansantoukin.PNG", pectoralisMajorMuscle);
          },
        ),
        */
        const SizedBox(
          height: 15,
        ),
        ResizedFitnessPng(
          png: "assets/img/gaihukusyakin.PNG",
          description: '腹斜筋',
          onTap: () {
            _navigateToSelectedFitness(
                '腹斜筋', "assets/img/gaihukusyakin.PNG", obliqueAbdominal);
          },
        ),
        const SizedBox(
          height: 15,
        ),
        ResizedFitnessPng(
          png: "assets/img/hukkin.PNG",
          description: '腹筋',
          onTap: () {
            _navigateToSelectedFitness('腹筋', "assets/img/hukkin.PNG", abs);
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
