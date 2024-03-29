import 'package:animated_background/animated_background.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:training/components/fitness_timer.dart';
import 'package:training/components/fitness_container.dart';
import 'package:training/controller/user_info.dart';
import 'package:training/controller/notifications.dart';
import 'package:training/models/Data/app_colors.dart';
import 'package:training/models/models.dart';
import 'package:training/view/pages/screen_widget.dart';

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
  final user = FirebaseAuth.instance;

  int _timer = 30;
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
            color: AppColors.contentColorWhite,
            icon: Icon(Icons.arrow_circle_left_outlined)),
        title: Text(
          widget.muscleDescription,
          style: TextStyle(color: AppColors.contentColorWhite),
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
            baseColor: Color.fromARGB(255, 27, 27, 27),
          ),
        ),
        vsync: this,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Consumer(
              builder: (context, watch, child) {
                final notificationViewModel = watch.read(notificationProvider);
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
                    user.currentUser != null ? create() : null;
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
                        closeIcon: Icon(
                          Icons.close,
                          size: 30,
                        ),
                        type: AlertType.success,
                        closeFunction: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return ScreenWidget();
                                },
                                fullscreenDialog: true),
                          );
                        }).show().then((value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) {
                                return ScreenWidget();
                              },
                              fullscreenDialog: true),
                        ));
                  },
                );
              },
            ),
            FitnessContainer(
                muscleDescription: widget.muscleDescription,
                musclePng: widget.musclePng,
                muscleLottie: widget.muscleLottie,
                index: widget.index)
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
        .doc(widget.muscleDescription)
        //Modelを使用してtitleに値を入れる
        .set({'title': widget.muscleDescription, 'time': dt});
  }
}
