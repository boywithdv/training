import 'package:flutter/material.dart';

class ProfileDefaultIcon extends StatefulWidget {
  const ProfileDefaultIcon({super.key});

  @override
  State<ProfileDefaultIcon> createState() => _ProfileDefaultIconState();
}

class _ProfileDefaultIconState extends State<ProfileDefaultIcon> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black54,
          child: Center(
            child: Icon(
              Icons.person,
              color: Colors.white70,
              size: 80,
            ),
          ),
        ),
        Positioned(
            top: 12,
            left: 24,
            child: Icon(
              Icons.camera,
              color: Color(0xFF50E4FF),
              size: 13,
            ))
      ],
    );
  }
}
