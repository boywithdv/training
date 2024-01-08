import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training/Data/iconData.dart';
import 'package:training/components/ProfileComponents/testProfileEdit.dart';
import 'package:training/controller/UserInfo.dart';
import 'package:training/controller/fitnessRecord.dart';
import 'package:training/main.dart';

class ContainerAvator extends StatefulWidget {
  const ContainerAvator({super.key});

  @override
  State<ContainerAvator> createState() => _ContainerAvatorState();
}

class _ContainerAvatorState extends State<ContainerAvator> {
  List<TrainingData> dataList = []; // TrainingDataのリスト
  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<void> _initData() async {
    userId = prefs.getString("uid");
    userName = prefs.getString('userName') ?? "";
    await _getDataFromFirebase();
    // データ取得後にsetStateを呼び出して反映させる
    setState(() {});
  }

  Future<void> _getDataFromFirebase() async {
    final service = FirestoreService();
    final List<TrainingData> data = await service.allread();
    dataList = data;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double sizedBoxHeight = height * 0.01;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  color: Colors.transparent,
                  height: height * 0.26,
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      double innerHeight = constraints.maxHeight;
                      double innerWidth = constraints.maxWidth;
                      return Stack(
                        fit: StackFit.expand,
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            //ぼかしの実装
                            child: BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                              child: Container(
                                height: innerHeight * 0.45,
                                width: innerWidth,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: innerHeight * 0.1,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: innerWidth * 0.3,
                                        ),
                                        Text(
                                          userName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 25,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            //iconボタンが押下された時に編集ウィジェットが画面下部から表示されるようになる
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        TestEdit(),
                                              ),
                                            );
                                          },
                                          icon: Icon(
                                            CupertinoIcons.pencil,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Favorite part of training",
                                      style: TextStyle(color: Colors.white70),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: innerWidth * 0.2,
                                backgroundImage:
                                    AssetImage("assets/img/user1.png"),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                //ここからコンテナ外のことをかく
                SizedBox(
                  height: sizedBoxHeight,
                ),
                Container(
                  height: height * 0.65,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListView.builder(
                    itemCount: dataList.length,
                    itemBuilder: (context, index) {
                      final reversedIndex = dataList.length - 1 - index;
                      final data = dataList[reversedIndex];
                      return Column(
                        children: [
                          SizedBox(
                            height: sizedBoxHeight,
                          ),
                          ListTile(
                            tileColor: Colors.transparent,
                            onTap: () {
                              //今後の更新で長押しするとその内容が表示されるようにする
                              print(data.title);
                            },
                            leading: Icon(
                              fitness_center_outlined,
                              color: Colors.white,
                            ),
                            title: Text(
                              data.title,
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text(
                              data.time.toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Divider(
                            height: 1,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          final FirestoreService service = FirestoreService();
          service.create();
          print(userId);
          setState(() {});
        },
        label: Icon(CupertinoIcons.add),
      ),
    );
  }
}
