import 'package:flutter/material.dart';
import 'package:training/controller/UserInfo.dart';
import 'package:training/pages/bodyRegistration/height_selection_screen.dart';
import 'package:training/pages/bodyRegistration/weight_selection_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

var fitnessHeight;
var fitnessWeight;

class CustomComponents extends StatefulWidget {
  const CustomComponents({Key? key}) : super(key: key);

  @override
  State<CustomComponents> createState() => _CustomComponentsState();
}

class _CustomComponentsState extends State<CustomComponents> {
  @override
  void initState() {
    _initializeData();
    super.initState();
  }

  Future<void> _initializeData() async {
    await readHeight();
    await readWeight();
    print(fitnessHeight);
    // setState()を呼んでビルドを再度トリガーする
    setState(() {});
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
            '登録するパラメータを選択してください',
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
                child: Height(),
              ),
              Components(
                text: "体重",
                params: '$fitnessWeight kg',
                child: WeightSelectionScreen(),
              )
            ],
          ),
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
      fitnessHeight = doc.data()?['HeightData'].toStringAsFixed(1);
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
      fitnessWeight = doc.data()?['WeightData'].toStringAsFixed(1);
      print(fitnessWeight);
    } else {
      fitnessWeight = null; // デフォルト値を設定するか、エラー処理を行うなど
    }
  }
}

class Components extends StatefulWidget {
  final String text;
  final String params;
  final Widget child;

  const Components({
    Key? key,
    required this.text,
    required this.child,
    required this.params,
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
                  builder: (BuildContext context) => widget.child));
        });
      },
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) => _controller.reverse(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _animation,
        child: Container(
          width: 150,
          height: 150,
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
                left: 0,
                child: Padding(
                    padding: EdgeInsets.all(8.0), child: Text(widget.params)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
