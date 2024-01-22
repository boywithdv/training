import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training/components/custom_components.dart';
import 'package:training/components/graphComponents/LinerGraph.dart';
import 'package:training/controller/UserInfo.dart';
import 'package:training/view/pages/bodyRegistration/height_selection_screen.dart';
import 'package:training/view/pages/bodyRegistration/weight_selection_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var fitnessHeight;
var fitnessWeight;

double calculateBMI(double heightInCentimeters, double weightInKilograms) {
  // 身長をメートルに変換
  double heightInMeters = heightInCentimeters / 100;
  // BMIを計算
  double bmi = weightInKilograms / (heightInMeters * heightInMeters);
  return bmi;
}

class BodyRegisterPage extends StatefulWidget {
  const BodyRegisterPage({Key? key}) : super(key: key);

  @override
  State<BodyRegisterPage> createState() => _BodyRegisterPageState();
}

class _BodyRegisterPageState extends State<BodyRegisterPage> {
  double bmi = 0.0;
  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  Future<void> _initializeData() async {
    await readHeight();
    await readWeight();
    calculateAndSetBMI();
    setState(() {});
  }

  void calculateAndSetBMI() {
    if (fitnessHeight != null && fitnessWeight != null) {
      double height = double.parse(fitnessHeight);
      double weight = double.parse(fitnessWeight);
      setState(() {
        bmi = calculateBMI(height, weight);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 40,
          ),
          Text(
            '体重は毎日更新してください',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 80,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomComponents(
                text: "身長",
                params: '$fitnessHeight cm',
                width: 150,
                height: 150,
                ontap: Height(),
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
                colors: Colors.white,
              ),
              CustomComponents(
                text: "体重",
                params: 'Today : $fitnessWeight kg',
                width: 150,
                height: 150,
                ontap: Weight(),
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 15,
                ),
                colors: Colors.white,
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          CustomComponents(
            text: 'BMI',
            ontap: null,
            params: 'Today BMI : ' + bmi.toStringAsFixed(1),
            width: 360,
            height: 240,
            child: GraphContainer(),
            icon: Icon(
              CupertinoIcons.person,
              size: 35,
            ),
            colors: Colors.white,
          )
        ],
      ),
    );
  }

  Future<void> readHeight() async {
    final db = FirebaseFirestore.instance;
    //DateTime dt = DateTime.now();
    //final days = dt.year.toString() + dt.month.toString() + dt.day.toString();
    final doc = await db
        .collection('userId')
        .doc(userId)
        .collection('height')
        //ここのdocはriverpodによりカウンターを作成してtest○○というようにする
        .doc('date')
        //Modelを使用してtitleに値を入れる
        .get();
    if (doc.exists) {
      // 'height' フィールドが存在する場合にのみ代入する
      fitnessHeight = doc.data()?['HeightData'] as double;
      fitnessHeight = fitnessHeight.toStringAsFixed(1);
    } else {
      fitnessHeight = null; // デフォルト値を設定するか、エラー処理を行うなど
    }
  }

  Future<void> readWeight() async {
    final db = FirebaseFirestore.instance;
    DateTime dt = DateTime.now();
    final days = dt.year.toString() + dt.month.toString() + dt.day.toString();
    final doc = await db
        .collection('userId')
        .doc(userId)
        .collection('weight')
        //ここのdocはriverpodによりカウンターを作成してtest○○というようにする
        //こうすることで翌日読み込むことが難しくなる days.toString()
        .doc(days)
        //Modelを使用してtitleに値を入れる
        .get();
    if (doc.exists) {
      // 'height' フィールドが存在する場合にのみ代入する
      fitnessWeight = doc.data()?['WeightData'] as double;
      //これでhourやday,yearが取得できる
      final fitnessTime = (doc.data()?["time"] as Timestamp).toDate();
      print(fitnessTime.day);
      fitnessWeight = fitnessWeight.toStringAsFixed(1);
    } else {
      fitnessWeight = null; // デフォルト値を設定するか、エラー処理を行うなど
    }
  }
}
