import 'package:flutter/material.dart';

class ProfileContainer extends StatefulWidget {
  const ProfileContainer({super.key});

  @override
  State<ProfileContainer> createState() => _ProfileContainerState();
}

class _ProfileContainerState extends State<ProfileContainer> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    double containerWidth = deviceWidth * 0.93;
    double containerHeight = deviceHeight * 0.5;
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
          width: containerWidth,
          height: containerHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: Color.fromARGB(247, 25, 43, 28),
          ),
          child: Center(
            child: Column(children: []),
          )),
    );
  }
}
