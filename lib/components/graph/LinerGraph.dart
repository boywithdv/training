import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training/components/custom_components.dart';
import 'package:training/components/graph/app_colors.dart';
import 'package:training/controller/UserInfo.dart';

import '../../main.dart';

var fitnessWeight;

class LinerGraph extends StatefulWidget {
  const LinerGraph({super.key});

  @override
  State<LinerGraph> createState() => _LinerGraphState();
}

class _LinerGraphState extends State<LinerGraph> {
  List<WeightData> weightDataList = [];
  TextEditingController _controller = TextEditingController();
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

  //ここでグラフのデータ取得
  Future<void> _getDataFromFirebase() async {
    final List<WeightData> data = await allread();
    weightDataList = data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("test"),
      ),
      body: Center(
        child: Components(
          text: 'BMI',
          ontap: null,
          params: _controller.text,
          width: 360,
          height: 240,
          child: GraphContainer(),
          icon: Icon(
            CupertinoIcons.person,
            size: 35,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await readWeight();
          await allread();
          setState(() {
            _controller.text = weightDataList[0].weight.toString();
          });
        },
        label: Icon(Icons.check),
      ),
    );
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
      fitnessWeight = fitnessWeight.toStringAsFixed(1);
    } else {
      //userIdがnullの場合がこれになる
      print(fitnessWeight);
    }
  }

  Future<List<WeightData>> allread() async {
    final db = FirebaseFirestore.instance;
    //ここでsnapshotにweightデータを取得する
    final snapshot =
        await db.collection('userId').doc(userId).collection('weight').get();

    // ドキュメントデータをList<TrainingData>として取得
    final List<WeightData> documents = snapshot.docs.map(
      (QueryDocumentSnapshot<Map<String, dynamic>> e) {
        final data = e.data();
        return WeightData(
          weight: data['WeightData'],
          time: data['time'].toDate(), // FirestoreのTimestampをDateTimeに変換
        );
      },
    ).toList();
    // documentsを使って何かしらの処理を行う
    for (var doc in documents) {
      // print(doc.time);
    }
    return documents;
  }
}

class WeightData {
  final double weight;
  final DateTime time;
  WeightData({required this.weight, required this.time});
}

class GraphContainer extends StatefulWidget {
  const GraphContainer({Key? key}) : super(key: key);

  @override
  State<GraphContainer> createState() => _GraphContainerState();
}

class _GraphContainerState extends State<GraphContainer> {
  late double currentWeight; // 本日の体重
  late List<FlSpot> spots; // グラフのデータポイント
  late double minY; // グラフのy軸最小値
  late double maxY; // グラフのy軸最大値
  bool animationCompleted = false;
  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];
  @override
  void initState() {
    minY = 70.0; // 初期値は80kgから-10kg
    maxY = 90.0; // 初期値は80kgから+10kg
    spots = [];

    // 本日の体重を取得（仮の例）
    getCurrentWeightFromFirebase().then((value) {
      setState(() {
        currentWeight = value;
        updateGraphData();
      });
    });

    // グラフにアニメーションを追加
    Future.delayed(Duration(milliseconds: 500), () {
      setState(() {
        animationCompleted = true;
      });
    });

    super.initState();
  }

  Future<double> getCurrentWeightFromFirebase() async {
    // Firebaseからのデータ取得ロジックを追加
    var snapshot = await FirebaseFirestore.instance
        .collection('weights')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return snapshot.docs.first['weight'];
    } else {
      return 0.0; // データがない場合のデフォルト値
    }
  }

  void updateGraphData() {
    double maxWeight = currentWeight + 40.0;
    spots = [
      FlSpot(0, 30),
      FlSpot(1, 24),
      FlSpot(2, 20),
      FlSpot(3, 19),
      FlSpot(4, 29),
      FlSpot(5, 32),
      FlSpot(6, 19),
      FlSpot(7, 20),
    ];

    // グラフのy軸範囲を更新
    setState(() {
      minY = 0;
      maxY = maxWeight;
      currentWeight = currentWeight;
      spots = spots;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340, // 任意の幅を指定
      height: 170, // 任意の高さを指定
      decoration: BoxDecoration(
        color: Color(0xff37434d),
        borderRadius: BorderRadius.circular(20),
      ),
      child: LineChart(
        LineChartData(
          // 中心のラインを設定
          gridData: FlGridData(
            show: true,
            drawVerticalLine: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(color: Colors.white, strokeWidth: 0);
            },
          ),
          // グラフの外側の数値を表示
          titlesData: FlTitlesData(
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),

          borderData: FlBorderData(
            show: true,
            border: Border.all(color: Colors.white, width: 1),
          ),

          minX: 0,
          maxX: 7,
          minY: minY,
          maxY: maxY,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              gradient: LinearGradient(
                colors: [
                  ColorTween(begin: gradientColors[0], end: gradientColors[1])
                      .lerp(0.2)!,
                  ColorTween(begin: gradientColors[0], end: gradientColors[1])
                      .lerp(0.2)!,
                ],
              ),
              barWidth: 4,
              color: gradientColors[0],
              dotData: FlDotData(show: false),
              isStrokeCapRound: true,
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: [
                    ColorTween(begin: gradientColors[0], end: gradientColors[1])
                        .lerp(0.2)!
                        .withOpacity(0.1),
                    ColorTween(begin: gradientColors[0], end: gradientColors[1])
                        .lerp(0.2)!
                        .withOpacity(0.1),
                  ],
                ),
              ),
            ),
          ],
        ),
        duration: const Duration(milliseconds: 0),
      ),
    );
  }
}
