import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:training/components/backgroundAnimation.dart';
import 'package:training/controller/UserInfo.dart';
import 'package:training/main.dart';
import 'package:training/pages/ScreenWidget.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({super.key});

  @override
  State<ProfileEdit> createState() => _ProfileEditState();
}

class _ProfileEditState extends State<ProfileEdit> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        BackgroundAnimation(),
        Positioned(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: TestEdit(),
          ),
        ),
      ],
    );
  }
}

class TestEdit extends StatefulWidget {
  const TestEdit({super.key});

  @override
  State<TestEdit> createState() => _TestEditState();
}

class _TestEditState extends State<TestEdit> {
  _TestEditState() {
    _selectedVal = _productFitnessList[0];
  }
  final TextEditingController _controller = TextEditingController();
  final _productFitnessList = [
    "大胸筋",
    "三角筋",
    "広背筋",
    "僧帽筋",
    "上腕三頭筋",
    "腹斜筋",
    "腹筋",
    "ハムストリング",
    "腓腹筋",
    "大臀筋",
    "大腿四頭筋"
  ];
  String? _selectedVal = "";
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double sizedboxWidth = width * 0.9;
    double sizedBoxHeight = height * 0.7;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
        child: Container(
          width: sizedboxWidth,
          height: sizedBoxHeight,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: Colors.black54),
          child: Column(
            children: [
              Text(
                'プロフィール変更',
                style: TextStyle(color: Colors.white, fontSize: 30),
              ),
              Container(
                width: 300,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 300,
                height: 40,
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  controller: _controller,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.person),
                    labelText: 'your name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                width: 200,
                child: DropdownButtonFormField(
                  dropdownColor: Colors.black87,
                  style: TextStyle(color: Colors.white),
                  value: _selectedVal,
                  items: _productFitnessList
                      .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                      .toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedVal = val;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.white70,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Favorite part of training",
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.accessibility_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        width: 140,
        child: FloatingActionButton(
          backgroundColor: Colors.white24,
          foregroundColor: Colors.white,
          onPressed: () {
            if (_controller.text == "" || _controller.text == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('名前が入力されていません。'),
                ),
              );
              return;
            }
            _saveName();
            updateDisplayName(userName);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => ScreenWidget()));
          },
          child: Icon(Icons.check),
        ),
      ),
    );
  }

  void _saveName() {
    setState(() {
      prefs.setString('userName', _controller.text);
      userName = prefs.getString("userName");
    });
  }
}
