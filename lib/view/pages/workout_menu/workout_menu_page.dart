import 'package:flutter/material.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/components/backgroundComponents.dart';
import 'package:training/components/fitnessPng.dart';
import 'package:training/components/selected_workout_menu.dart';
import 'package:training/components/workout_menu_components.dart';
import 'package:training/models/Data/app_colors.dart';
import 'package:training/models/models.dart';

class WorkoutMenuPage extends StatefulWidget {
  const WorkoutMenuPage({super.key});

  @override
  State<WorkoutMenuPage> createState() => _WorkoutMenuPageState();
}

class _WorkoutMenuPageState extends State<WorkoutMenuPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('メニュー作成',
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.elliptical(10, 30),
          ),
        ),
        elevation: 0,
        leading: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          BackgroundAnimation(),
          BackgroundComponents(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  WorkoutMenuComponents(
                      height: 100,
                      width: 160,
                      colors: AppColors.contentColorWhite,
                      widgetChild: Row(
                        children: [
                          FitnessPng(png: "assets/img/daikyoukin.png"),
                          Text("大胸筋")
                        ],
                      ),
                      ontap: () => _navigateToSelectedFitness('大胸筋',
                          "assets/img/daikyoukin.png", pectoralisMajorMuscle)),
                  WorkoutMenuComponents(
                      height: 100,
                      width: 160,
                      colors: AppColors.contentColorWhite,
                      widgetChild: Row(
                        children: [
                          FitnessPng(png: "assets/img/gaihukusyakin.PNG"),
                          Text("腹斜筋")
                        ],
                      ),
                      ontap: () => _navigateToSelectedFitness('腹斜筋',
                          "assets/img/gaihukusyakin.PNG", obliqueAbdominal)),
                  WorkoutMenuComponents(
                      height: 100,
                      width: 160,
                      colors: AppColors.contentColorWhite,
                      widgetChild: Row(
                        children: [
                          FitnessPng(png: "assets/img/hukkin.PNG"),
                          Text("腹筋")
                        ],
                      ),
                      ontap: () => _navigateToSelectedFitness(
                          '腹斜筋', "assets/img/gaihukusyakin.PNG", abs)),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  WorkoutMenuComponents(
                      height: 100,
                      width: 160,
                      colors: AppColors.contentColorWhite,
                      widgetChild: Row(
                        children: [
                          FitnessPng(png: "assets/img/kata_sankakukin.PNG"),
                          Text("三角筋")
                        ],
                      ),
                      ontap: () => _navigateToSelectedFitness(
                          '三角筋', "assets/img/kata_sankakukin.PNG", deltoid)),
                  WorkoutMenuComponents(
                      height: 100,
                      width: 160,
                      colors: AppColors.contentColorWhite,
                      widgetChild: Row(
                        children: [
                          FitnessPng(png: "assets/img/oshiri.PNG"),
                          Text("大臀筋")
                        ],
                      ),
                      ontap: () => _navigateToSelectedFitness(
                          '大臀筋', "assets/img/oshiri.PNG", buttocks)),
                  WorkoutMenuComponents(
                      height: 100,
                      width: 160,
                      colors: AppColors.contentColorWhite,
                      widgetChild: Row(
                        children: [
                          FitnessPng(png: "assets/img/daitaisitoukin.PNG"),
                          Text("大腿四頭筋")
                        ],
                      ),
                      ontap: () => _navigateToSelectedFitness(
                          '大腿四頭筋', "assets/img/daitaisitoukin.PNG", thigh)),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  void _navigateToSelectedFitness(
      String name, String png, List<FitnessModel> fitnessMenu) {
    Navigator.of(context, rootNavigator: true).push(
      PageRouteBuilder(
        opaque: true,
        pageBuilder: (BuildContext context, _, __) {
          return SelectedWorkoutMenu(
            titleName: name,
            selectedBodyName: fitnessMenu,
            png: png,
          );
        },
      ),
    );
  }
}
