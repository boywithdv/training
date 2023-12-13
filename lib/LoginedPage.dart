import 'package:flutter/material.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:go_router/go_router.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Stack(children: [BackgroundAnimation()]),
    );
  }
}
