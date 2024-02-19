import 'package:flutter/material.dart';
import 'package:training/components/selectedfitness.dart';
import 'package:training/models/Data/app_colors.dart';
import 'package:training/models/models.dart';

class SelectedWorkoutMenu extends StatefulWidget {
  final String? titleName;
  final List<FitnessModel> selectedBodyName;
  final String png;

  const SelectedWorkoutMenu(
      {super.key,
      this.titleName,
      required this.selectedBodyName,
      required this.png});

  @override
  State<SelectedWorkoutMenu> createState() => _SelectedWorkoutMenuState();
}

class _SelectedWorkoutMenuState extends State<SelectedWorkoutMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.titleName ?? ""),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: widget.selectedBodyName.length,
          itemBuilder: (context, index) {
            FitnessModel fitness = widget.selectedBodyName[index];
            return Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.pageBackground,
                  ),
                  child: ListTile(
                    //ここからlistviewで値を変更するが、モデルによって違う
                    title: Text(
                      fitness.fitnessName,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Colors.white,
                    onTap: () {
                      _navigateToSelectedFitness(fitness.fitnessName,
                          widget.png, widget.selectedBodyName, index);
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void _navigateToSelectedFitness(String musclePng, String fitnessPng,
      List<FitnessModel> selectedBodyName, int index) {
    Navigator.of(context, rootNavigator: true).push(PageRouteBuilder(
        opaque: true,
        pageBuilder: (BuildContext context, _, __) {
          return SelectedFitness(
              muscleDescription: musclePng,
              musclePng: fitnessPng,
              muscleLottie: selectedBodyName,
              index: index);
        }));
  }
}
