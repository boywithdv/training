import 'package:animated_background/animated_background.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:training/components/LottieAnimation.dart';
import 'package:training/components/FitnessTimer.dart';
import 'package:training/components/ImageCircle.dart';
import 'package:training/controller/UserInfo.dart';
import 'package:training/controller/notifications.dart';
import 'package:training/models/models.dart';

final notificationProvider = Provider<NotificationViewModel>((ref) {
  return NotificationViewModel(ref.read);
});

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
  final db = FirebaseFirestore.instance;

  int _timer = 20;
  bool _isPause = true;
  void initState() {
    super.initState();
    _controller.resume();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double sizedBoxWidthToTimer = deviceWidth * 0.25;
    double sizedBoxHeightToTimer = deviceHeight * 0.47;
    double fitnessNameTop = deviceHeight * 0.31;
    double fitnessComponentTop = deviceHeight * 0.42;
    double fitnessNameLeft = deviceWidth * 0;
    double fitnessAnimation = deviceHeight * 0.4;
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
                bottom: sizedBoxHeightToTimer,
                left: sizedBoxWidthToTimer,
                child: Consumer(
                  builder: (context, watch, child) {
                    final notificationViewModel =
                        watch.read(notificationProvider);

                    return FitNessT(
                      timer: _timer,
                      controller: _controller,
                      onStart: () {},
                      autoStart: false,
                      onComplete: () {
                        setState(
                          () {
                            _controller.pause();
                            notificationViewModel.showNotification();
                          },
                        );
                        create();
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
                    );
                  },
                )),
            Positioned(
                top: fitnessNameTop,
                left: fitnessNameLeft,
                child: Container(
                  width: 380,
                  height: 90,
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: ImageCircle(
                    png: widget.musclePng,
                    description: widget.muscleDescription,
                    fontsize: 14,
                  ),
                )),
            Positioned(
                top: fitnessComponentTop,
                left: fitnessNameLeft,
                child: Container(
                  width: 390,
                  height: 290,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color.fromARGB(188, 63, 81, 181)),
                )),
            Positioned(
              top: fitnessAnimation,
              left: fitnessNameLeft,
              child: LottieFiles(
                  lottie: widget.muscleLottie[widget.index].fitnessLottieName),
            ),
          ],
        ),
      ),
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

  Future<void> create() async {
    DateTime dt = DateTime.now();
    await db
        .collection('userId')
        .doc(userId)
        .collection('fitness')
        .doc(dt.year.toString() +
            '-' +
            dt.month.toString() +
            '-' +
            dt.day.toString())
        .collection('training')
        //ここのdocはriverpodによりカウンターを作成してtest○○というようにする
        .doc(widget.muscleDescription)
        //Modelを使用してtitleに値を入れる
        .set({'title': widget.muscleDescription, 'time': dt});
  }
}
