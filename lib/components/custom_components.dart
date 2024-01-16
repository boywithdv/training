import 'package:flutter/material.dart';
import 'package:training/controller/UserInfo.dart';
import 'package:training/pages/Profile/Profile.dart';
import 'package:training/pages/bodyRegistration/height_selection_screen.dart';
import 'package:training/pages/bodyRegistration/weight_selection_screen.dart';
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

class CustomComponents extends StatefulWidget {
  const CustomComponents({Key? key}) : super(key: key);

  @override
  State<CustomComponents> createState() => _CustomComponentsState();
}

class _CustomComponentsState extends State<CustomComponents> {
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
              Components(
                text: "身長",
                params: '$fitnessHeight cm',
                width: 150,
                height: 150,
                ontap: Height(),
              ),
              Components(
                text: "体重",
                params: '$fitnessWeight kg',
                width: 150,
                height: 150,
                ontap: WeightSelectionScreen(),
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Components(
              text: 'BMI',
              ontap: MainContents(),
              params: bmi.toStringAsFixed(1),
              width: 360,
              height: 200)
        ],
      ),
    );
  }

  Future<void> readHeight() async {
    final db = FirebaseFirestore.instance;
    final doc = await db
        .collection('userId')
        .doc(userId)
        .collection('height')
        //ここのdocはriverpodによりカウンターを作成してtest○○というようにする
        .doc('data')
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
    final doc = await db
        .collection('userId')
        .doc(userId)
        .collection('weight')
        //ここのdocはriverpodによりカウンターを作成してtest○○というようにする
        .doc('data')
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

class Components extends StatefulWidget {
  final String text;
  final String params;
  final Widget ontap;
  final double width;
  final double height;

  const Components({
    Key? key,
    required this.text,
    required this.ontap,
    required this.params,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  _ComponentsState createState() => _ComponentsState();
}

class _ComponentsState extends State<Components>
    with SingleTickerProviderStateMixin {
  bool isTapped = false;
  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 200),
    vsync: this,
  );
  late final _animation = _controller.drive(Tween<double>(begin: 1, end: 0.95));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isTapped = !isTapped;
        });
        // Navigatorをアニメーション後に呼び出す
        _controller.reverse().then((_) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => widget.ontap));
        });
      },
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
              color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 10,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 5,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                  ),
                ),
              ),
              Positioned(
                top: 35,
                left: 10,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    widget.params,
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
