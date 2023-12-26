import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:training/components/backgroundAnimation.dart';

import 'package:training/controller/UserInfo.dart';
import 'package:training/main.dart';
import 'package:training/pages/Profile/Profile.dart';
import 'package:training/pages/ScreenWidget.dart';

class TestEdit extends StatefulWidget {
  const TestEdit({super.key});

  @override
  State<TestEdit> createState() => _TestEditState();
}

class _TestEditState extends State<TestEdit> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            BackgroundAnimation(),
            Center(
              child: Container(
                width: 200,
                height: 40,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    focusColor: Colors.white,
                    hoverColor: Colors.white,
                    labelText: 'your name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          width: 140,
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            onPressed: () {
              _saveName();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => ScreenWidget()));
            },
            child: Text(" 編集"),
          ),
        ));
  }

  void _saveName() {
    setState(() {
      prefs.setString('username', _controller.text);
      userName = prefs.getString("username");
    });
  }
}
