import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:training/components/backgroundAnimationToFitness.dart';
import 'package:training/components/resizedFitnessPng.dart';
import 'package:training/controller/admob.dart';
import 'package:training/models/models.dart';

class ToLowerBody extends StatefulWidget {
  const ToLowerBody({super.key});

  @override
  State<ToLowerBody> createState() => _ToLowerBodyState();
}

class _ToLowerBodyState extends State<ToLowerBody> {
  final AdMob _adMob = AdMob();
  @override
  void initState() {
    super.initState();
    //_adMob.load();
  }

  @override
  void dispose() {
    super.dispose();
    //_adMob.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Column(
        children: [
          /*
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
          */
          SizedBox(
            height: 40,
          ),
          /*
          ResizedFitnessPng(
            png: "assets/img/hamusutoring.PNG",
            description: 'ハムストリングス',
            onTap: () {
              print("ハムストリング");
              _navigateToSelectedFitness(
                  'ハムストリング', 'assets/img/hamusutoring.PNG', thigh);
            },
          ),
          SizedBox(
            height: 15,
          ),
          ResizedFitnessPng(
            png: "assets/img/hihukukin.PNG",
            description: '腓腹筋',
            onTap: () {
              _navigateToSelectedFitness(
                  "腓腹筋", "assets/img/hihukukin.PNG", thigh);
            },
          ),
          SizedBox(
            height: 15,
          ),
          */
          ResizedFitnessPng(
            png: "assets/img/oshiri.PNG",
            description: '大臀筋',
            onTap: () {
              _navigateToSelectedFitness(
                  '大臀筋', 'assets/img/oshiri.PNG', buttocks);
            },
          ),
          SizedBox(
            height: 15,
          ),
          ResizedFitnessPng(
            png: "assets/img/daitaisitoukin.PNG",
            description: '大腿四頭筋',
            onTap: () {
              print("大腿四頭筋");
              _navigateToSelectedFitness(
                  '大腿四頭筋', 'assets/img/daitaisitoukin.PNG', thigh);
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
