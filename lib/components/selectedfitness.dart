import 'package:animated_background/animated_background.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:training/Lottie/LottieAnimation.dart';
import 'package:training/components/FitnessTimer.dart';
import 'package:training/components/ImageCircle.dart';
import 'package:training/models/models.dart';

class SelectedFitness extends StatefulWidget {
  final String muscleDescription;
  final String musclePng;
  final List<FitnessModel> muscleLottie;
  final int index;
  const SelectedFitness({
    super.key,
    required this.muscleDescription,
    required this.musclePng,
    required this.muscleLottie,
    required this.index,
  });

  @override
  State<SelectedFitness> createState() => _SelectedFitnessState();
}

class _SelectedFitnessState extends State<SelectedFitness>
    with TickerProviderStateMixin {
  CountDownController _controller = CountDownController();
  int _timer = 10;
  bool _isPause = true;
  void initState() {
    super.initState();
    _controller.resume();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
            icon: Icon(Icons.arrow_circle_left_outlined)),
        title: Text(
          widget.muscleDescription,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: AnimatedBackground(
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
          child: Stack(
            children: [
              Positioned(
                bottom: 400,
                left: 100,
                child: FitNessT(
                  timer: _timer,
                  controller: _controller,
                  onStart: () {},
                  autoStart: false,
                  onComplete: () {
                    setState(() {
                      _controller.pause();
                    });
                    Alert(
                            context: context,
                            title: '終了',
                            style: AlertStyle(
                              isCloseButton: true,
                              isButtonVisible: false,
                              titleStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 30.0,
                              ),
                            ),
                            type: AlertType.success)
                        .show();
                  },
                ),
              ),
              Positioned(
                  top: 270,
                  child: Container(
                    width: 390,
                    height: 90,
                    decoration: BoxDecoration(
                      border: Border.all(),
                    ),
                    child: ImageCircle(
                      png: widget.musclePng,
                      description: widget.muscleDescription,
                      fontsize: 24,
                    ),
                  )),
              Positioned(
                  top: 380,
                  child: Container(
                    width: 390,
                    height: 240,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(231, 63, 81, 181)),
                  )),
              Positioned(
                  top: 320,
                  child: Container(
                    width: 390,
                    height: 300,
                    child: LottieFiles(
                        lottie: widget
                            .muscleLottie[widget.index].fitnessLottieName),
                  )),
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromARGB(122, 255, 255, 255),
        onPressed: () {
          setState(() {
            if (_isPause) {
              _isPause = false;
              _controller.resume();
            } else {
              _isPause = true;
              _controller.pause();
            }
          });
        },
        icon: Icon(_isPause ? Icons.play_arrow : Icons.pause),
        label: Text(_isPause ? '開始' : '停止'),
      ),
    );
  }
}
