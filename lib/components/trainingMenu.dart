import 'package:flutter/material.dart';

import 'package:showcaseview/showcaseview.dart';
import 'package:training/components/selectedfitness.dart';
import 'package:training/models/models.dart';

class TrainingMenu extends StatefulWidget {
  final String title;
  final String png;
  final List<FitnessModel> lottieName;
  const TrainingMenu({
    super.key,
    required this.title,
    required this.png,
    required this.lottieName,
  });

  @override
  State<TrainingMenu> createState() => _TrainingMenuState();
}

class _TrainingMenuState extends State<TrainingMenu>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.lottieName.length,
      itemBuilder: (context, index) {
        FitnessModel fitness = widget.lottieName[index];
        return Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromARGB(132, 255, 255, 255)),
              child: ListTile(
                //ここからlistviewで値を変更するが、モデルによって違う
                title: Text(
                  fitness.fitnessName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                textColor: Colors.white,
                onTap: () {
                  print(widget.title);
                  _navigateToSelectedFitness(fitness.fitnessName, widget.png,
                      widget.lottieName, index);
                },
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
        );
      },
    );
  }

  void _navigateToSelectedFitness(String muscleName, String musclePng,
      List<FitnessModel> muscleLottie, int index) {
    Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
        opaque: true,
        pageBuilder: (BuildContext context, _, __) {
          print(widget.lottieName);
          return SelectedFitness(
              muscleDescription: muscleName,
              musclePng: musclePng,
              muscleLottie: muscleLottie,
              index: index);
        }));
  }
}
