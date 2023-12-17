import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';

class TrainingMenuList extends StatefulWidget {
  const TrainingMenuList({super.key});

  @override
  State<TrainingMenuList> createState() => _TrainingMenuListState();
}

class _TrainingMenuListState extends State<TrainingMenuList>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            spawnMaxRadius: 50,
            spawnMinSpeed: 10.00,
            particleCount: 68,
            spawnMaxSpeed: 50,
            minOpacity: 0.3,
            spawnOpacity: 0.4,
            baseColor: Color.fromARGB(119, 0, 34, 23),
          ),
        ),
        vsync: this,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: const Text(
              '腕立て伏せ',
              style: TextStyle(color: Colors.white),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_circle_left_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Center(
            child: Hero(
              tag: 'udetatehuse',
              child: Material(
                  color: Colors.transparent,
                  child: Card(
                    child: ListTile(
                      title: const Text(
                        '腕立て伏せ',
                        style: TextStyle(color: Colors.white),
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      subtitle: const Text(''),
                      tileColor: Colors.indigo,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  )),
            ),
          ),
        ));
  }
}
