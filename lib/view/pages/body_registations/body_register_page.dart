import 'package:flutter/material.dart';
import 'package:training/components/custom_components.dart';
import 'package:training/components/graphComponents/LinerGraph.dart';
import 'package:training/controller/UserInfo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:training/view/pages/body_registations/height_selection_screen.dart';
import 'package:training/view/pages/body_registations/weight_selection_screen.dart';

var fitnessHeight;
var fitnessWeight;
var heightRegisterDays;
var weightRegisterDays;
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
    await getLastWeightDate();
    await getLastHeightDate();
    await calculateAndSetBMI();
    setState(() {});
  }

  Future<void> calculateAndSetBMI() async {
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
                registerDays: heightRegisterDays == null
                    ? ""
                    : "更新日 \n $heightRegisterDays",
                text: "身長",
                params: fitnessHeight == null ? null : '$fitnessHeight cm',
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
                registerDays: weightRegisterDays == null
                    ? ""
                    : "更新日 \n $weightRegisterDays",
                text: "体重",
                params:
                    fitnessWeight == null ? null : "Today : $fitnessWeight kg",
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
              Icons.person,
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

  Future<DateTime?> getLastWeightDate() async {
    DateTime? lastWeightDate;

    try {
      final db = FirebaseFirestore.instance;
      final querySnapshot = await db
          .collection('userId')
          .doc(userId)
          .collection('weight')
          .orderBy('time', descending: true) // 最新のデータから順に取得
          .limit(1) // 1つのデータだけ取得
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // 最新の体重データの日付を取得
        final doc = querySnapshot.docs.first;
        final timestamp = doc['time'] as Timestamp;
        lastWeightDate = timestamp.toDate();
        weightRegisterDays = lastWeightDate.year.toString() +
            "年" +
            lastWeightDate.month.toString() +
            "月" +
            lastWeightDate.day.toString() +
            "日";
        print(weightRegisterDays);
      }
    } catch (error) {
      print('Error retrieving last weight date: $error');
    }

    return lastWeightDate;
  }

  Future<DateTime?> getLastHeightDate() async {
    DateTime? lastHeightDate;

    try {
      final db = FirebaseFirestore.instance;
      final docSnapshot = await db
          .collection('userId')
          .doc(userId)
          .collection('height')
          .doc('date')
          .get();

      if (docSnapshot.exists) {
        // 日付を取得
        final timestamp = docSnapshot['time'] as Timestamp;
        lastHeightDate = timestamp.toDate();
        heightRegisterDays = lastHeightDate.year.toString() +
            "年" +
            lastHeightDate.month.toString() +
            "月" +
            lastHeightDate.day.toString() +
            "日";
      }
    } catch (error) {
      print('Error retrieving height date: $error');
    }

    return lastHeightDate;
  }
}
