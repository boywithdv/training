import 'package:flutter/material.dart';
import 'package:training/components/backgroundAnimationToLower.dart';
import 'package:training/components/backgroundAnimationToUpper.dart';

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
        body: TabBarView(
          children: [
            BackgroundAnimationToUpper(),
            BackgroundAnimationToLower()
          ],
        ));
  }
}
