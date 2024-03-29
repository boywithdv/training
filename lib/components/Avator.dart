import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:training/components/lottie_container.dart';
import 'package:training/controller/user_info.dart';

class Avator extends StatefulWidget {
  const Avator({super.key});

  @override
  State<Avator> createState() => _AvatorState();
}

class _AvatorState extends State<Avator> {
  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    userId = prefs.getString("uid");
    userName = prefs.getString('userName') ?? "";
    favorite_part_of_training =
        prefs.getString("favorite_part_of_training") ?? "";
    // データ取得後にsetStateを呼び出して反映させる
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.transparent,
      height: height * 0.45,
      child: LayoutBuilder(
        builder: (context, constraints) {
          double innerHeight = constraints.maxHeight;
          double innerWidth = constraints.maxWidth;
          return Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 0,
                left: width * 0.1,
                child: LottieContainer(
                  width: width * 0.7,
                ),
              ),
              Positioned(
                top: width * 0.37,
                left: 0,
                //ぼかしの実装
                child: Container(
                  height: innerHeight * 0.3,
                  width: innerWidth,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(95, 255, 255, 255),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: innerHeight * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                            child: Text(
                              userName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "お気に筋トレ部位",
                        style: TextStyle(color: Colors.white70),
                      ),
                      Text(
                        favorite_part_of_training ?? "",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
