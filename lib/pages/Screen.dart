import 'package:flutter/material.dart';
import 'package:rive/rive.dart';
import 'package:training/components/backgroundAnimationToLower.dart';
import 'package:training/components/backgroundAnimationToUpper.dart';
import 'package:training/components/menuBarComponents/ThemeColor.dart';
import 'package:training/components/menuBarComponents/animated_bar.dart';
import 'package:training/components/menuBarComponents/rive_assets.dart';
import 'package:training/components/menuBarComponents/rive_utils.dart';
import 'package:training/components/menuBarComponents/timerSettings.dart';
import 'package:training/login/login.dart';

class ScreenWidget extends StatelessWidget {
  const ScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        child: Screen(),
        length: 2,
      ),
    );
  }
}

class Screen extends StatefulWidget {
  const Screen({super.key});

  @override
  State<Screen> createState() => _ScreenState();
}

class _ScreenState extends State<Screen> {
  RiveAsset selectedBottomNav = bottomNavs.last;
  Widget cureentWidget = MainContents();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: cureentWidget,
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(horizontal: 80),
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.green),
            borderRadius: const BorderRadius.all(Radius.circular(24)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                bottomNavs.length,
                (index) => GestureDetector(
                  onTap: () {
                    bottomNavs[index].input!.change(true);
                    if (bottomNavs[index] != selectedBottomNav) {
                      setState(() {
                        selectedBottomNav = bottomNavs[index];
                        switch (index) {
                          case 0:
                            cureentWidget = Fitness();
                          case 1:
                            cureentWidget = Container(
                              color: Colors.red,
                              child: Center(child: Text("red")),
                            );
                          case 2:
                            cureentWidget = MainContents();
                        }
                      });
                    }
                    Future.delayed(const Duration(seconds: 1), () {
                      bottomNavs[index].input!.change(false);
                    });
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedBar(
                          isActive: bottomNavs[index] == selectedBottomNav),
                      SizedBox(
                        height: 36,
                        width: 36,
                        child: Opacity(
                          opacity:
                              bottomNavs[index] == selectedBottomNav ? 1 : 0.5,
                          child: RiveAnimation.asset(
                            bottomNavs.first.src,
                            artboard: bottomNavs[index].artboard,
                            onInit: (artboard) {
                              StateMachineController controller =
                                  RiveUtils.getRiveController(artboard,
                                      stateMachineName:
                                          bottomNavs[index].stateMachineName);
                              bottomNavs[index].input =
                                  controller.findSMI("active") as SMIBool;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Fitness extends StatefulWidget {
  const Fitness({super.key});

  @override
  State<Fitness> createState() => _FitnessState();
}

class _FitnessState extends State<Fitness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            "部位選択",
            style: TextStyle(color: const Color.fromARGB(204, 255, 255, 255)),
          ),
          backgroundColor: Colors.transparent,
          bottom: TabBar(
            tabs: [
              Tab(
                text: "上半身",
              ),
              Tab(
                text: "下半身",
              ),
            ],
            labelColor: Colors.white,
          ),
        ),
        body: Stack(
          children: [
            TabBarView(
              children: [
                BackgroundAnimationToUpper(),
                BackgroundAnimationToLower()
              ],
            ),
          ],
        ));
  }
}
