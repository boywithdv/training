import 'package:flutter/material.dart';
import 'package:training/controller/UserInfo.dart';
import 'package:training/main.dart';
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
        appBar: AppBar(
          backgroundColor: Colors.black,
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
        backgroundColor: Colors.black,
        body: Center(
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
                    labelText: 'your name',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  "Favorite part of training",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Container(
          width: 140,
          child: FloatingActionButton(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            onPressed: () {
              _saveName();
              updateDisplayName(userName);
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
      prefs.setString('userName', _controller.text);
      userName = prefs.getString("userName");
    });
  }
}
