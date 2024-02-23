import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:training/components/Avator.dart';
import 'package:training/controller/admob.dart';
import 'package:training/view/pages/profile/profile_edit.dart';
import 'package:training/components/custom_components.dart';
import 'package:training/controller/UserInfo.dart';
import 'package:training/controller/fitnessRecord.dart';

class ContainerAvator extends StatefulWidget {
  const ContainerAvator({super.key});

  @override
  State<ContainerAvator> createState() => _ContainerAvatorState();
}

class _ContainerAvatorState extends State<ContainerAvator> {
  final AdMob _adMob = AdMob();

  List<TrainingData> dataList = [];
  @override
  void initState() {
    super.initState();
    _initData();
    _adMob.load();
  }

  Future<void> _initData() async {
    userId = prefs.getString("uid");
    userName = prefs.getString('userName') ?? "";
    favorite_part_of_training =
        prefs.getString("favorite_part_of_training") ?? "";
    await _getDataFromFirebase();
    // データ取得後にsetStateを呼び出して反映させる
    setState(() {});
  }

  Future<void> _getDataFromFirebase() async {
    final service = FirestoreService();
    final List<TrainingData> data = await service.allread();
    await service.read();

    dataList = data;
  }

  @override
  void dispose() {
    super.dispose();
    _adMob.dispose();
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
                Avator(),
                SizedBox(
                  height: sizedBoxHeight,
                ),
                //ここからコンテナ外のことをかく
                FutureBuilder(
                  future: AdSize.getAnchoredAdaptiveBannerAdSize(
                    Orientation.portrait,
                    MediaQuery.of(context).size.width.truncate(),
                  ),
                  builder: (BuildContext context,
                      AsyncSnapshot<AnchoredAdaptiveBannerAdSize?> snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                        width: double.infinity,
                        child: _adMob.getAdBanner(),
                      );
                    } else {
                      return Container(
                        height: _adMob.getAdBannerHeight(),
                        color: Colors.white,
                      );
                    }
                  },
                ),
                Container(
                  width: width,
                  height: height * 0.05,
                  child: Center(
                    child: Text(
                      "Today Fitness Record",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: sizedBoxHeight,
                ),
                Container(
                  height: height * 0.65,
                  width: width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
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
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ListTile(
                              tileColor: Colors.transparent,
                              onTap: () {
                                //今後の更新で長押しするとその内容が表示されるようにする
                                print(data.title);
                              },
                              leading: Icon(
                                Icons.fitness_center,
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
                          ),
                          Divider(),
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
      floatingActionButton: CustomComponents(
        colors: Colors.white60,
        ontap: ProfileEdit(),
        width: 130,
        height: 50,
        widgetChild: Text(
          "プロフィール編集",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
